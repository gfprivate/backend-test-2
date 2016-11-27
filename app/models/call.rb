class Call < ActiveRecord::Base
  has_one :user

  STATUS_ONGOING = 'ongoing'
  STATUS_DONE = 'done'

  def self.log(call_id, service, service_call_id, from, to, user_id)
    call = self.find_or_initialize_by(id: call_id)

    if call.new_record?
      call.service = service
      call.from = from
      call.to = to
      call.status = STATUS_ONGOING
    end

    call.service_call_id = service_call_id
    call.user_id = user_id
    call.save
    call
  end

  def self.end_on_voicemail(call_id, service_call_id, voicemail_url)
    call = Call.where(id: call_id, status: STATUS_ONGOING)
    return if call.nil?

    call.user_id = nil
    call.service_call_id = service_call_id
    call.voicemail_url = voicemail_url
    call.status = STATUS_DONE
    call.save
  end

  def self.end_on_hangup(service_call_id)
    call = Call.where(service_call_id: service_call_id, status: STATUS_ONGOING).first
    return if call.nil?

    call.status = STATUS_DONE
    call.save
  end
end
