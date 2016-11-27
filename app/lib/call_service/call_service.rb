class CallService::CallService
  SERVICES = ['plivo']

  def self.is_handled(service)
    SERVICES.include? service
  end

  def self.get_service (service)
    return nil unless self.is_handled service

    case service
    when 'plivo'
      CallService::PlivoService
    else
      nil
    end
  end

  # Interface

  def self.get_caller_number_from_payload(payload)
    raise "Missing implementation"
  end

  def self.get_endpoint_from_payload(payload)
    raise "Missing implementation"
  end

  def self.get_voicemail_url_from_payload(payload)
    raise "Missing implementation"
  end

  def self.get_service_call_id_from_payload(payload)
    raise "Missing implementation"
  end

  def self.content_type
    raise "Missing implementation"
  end

  def self.forward_next_call_queue_response(call_id, endpoint, from, to, order)
    raise "Missing implementation"
  end

  def self.go_to_voicemail(call_id)
    raise "Missing implementation"
  end
end
