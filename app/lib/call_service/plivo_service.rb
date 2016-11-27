require 'plivo'

class CallService::PlivoService < CallService::CallService
  SERVICE_NAME = "plivo"
  LOG_PREFIX = "[PlivoService]"

  def self.get_caller_number_from_payload(payload)
    payload[:From]
  end

  def self.get_endpoint_from_payload(payload)
    payload[:To]
  end

  def self.get_voicemail_url_from_payload(payload)
    payload[:RecordUrl]
  end

  def self.get_service_call_id_from_payload(payload)
    payload[:CallUUID]
  end

  def self.content_type
    return 'text/xml'
  end

  def self.forward_next_call_queue_response(call_id, sip_endpoint, from, to, order)
    r = Plivo::Response.new()

    next_call_url = get_call_action_url call_id, from, to, order

    params = {
      'callerId' => from,
      'action' => next_call_url,
      'method' => 'POST'
    }

    d = r.addDial(params)
    d.addNumber(sip_endpoint)

    return r.to_s()
  end

  def self.go_to_voicemail(call_id)
    r = Plivo::Response.new()

    voicemail_options = get_voicemail_options
    r.addSpeak(voicemail_options['message'], voicemail_options['params'])

    r.addRecord({
      'action' => get_record_action_url(call_id),
      'method' => 'POST'
    })

    r.addHangup({
      'reason' => 'No message'
    })

    return r.to_s()
  end

  private
    def self.get_call_action_url(call_id, from, to, order)
      url = Rails.application.config.webhooks_base_url
      url += "/webhooks/#{SERVICE_NAME}/call/inbound?"
      url += {
        'To' => to,
        'From' => from,
        'order' => order,
        'call_id' => call_id
      }.to_query
    end

    def self.get_voicemail_options
      options = {
        'message' => Rails.application.config.voicemail_message,
        'params' => {
          'language'=> "en-US",
          'voice' => "MAN"
        }
      }
    end

    def self.get_record_action_url(call_id)
      url = Rails.application.config.webhooks_base_url
      url += "/webhooks/#{SERVICE_NAME}/call/voicemail/complete?"
      url += {
        'call_id' => call_id
      }.to_query
    end
end
