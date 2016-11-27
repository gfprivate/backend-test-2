class Webhooks::CallsController < ActionController::Base
  LOG_PREFIX = "[Webhook]"

  def inbound_call
    service_name = params[:service]
    order = params[:order] || 0
    call_id = params[:call_id]

    logger.info "#{LOG_PREFIX} [Call] status: received | service: #{service_name}"

    service = CallService::CallService.get_service service_name
    return not_found if service.nil?

    from_number = service.get_caller_number_from_payload params
    to_endpoint = service.get_endpoint_from_payload params
    service_call_id = service.get_service_call_id_from_payload params
    previous_order = order

    assignee = CompanyNumber.getNextAssigneeFromEndpoint to_endpoint, order

    content_type = service.content_type

    if assignee.nil?
      body = service.go_to_voicemail call_id
      logger.error "#{LOG_PREFIX} [Call] Sent to voicemail"
    else
      call = Call.log call_id, service_name, service_call_id, from_number, to_endpoint, assignee.user.id

      sip_endpoint = assignee.user.user_number.sip_endpoint
      body = service.forward_next_call_queue_response call.id, sip_endpoint, from_number, to_endpoint, assignee.order
      logger.error "#{LOG_PREFIX} [Call] Forwarded to #{assignee.user.user_number.sip_endpoint}"
    end

    render inline: body, content_type: content_type
  end

  def voicemail
    service_name = params[:service]
    call_id = params[:call_id]

    logger.info "#{LOG_PREFIX} [Call] status: voicemail received | service: #{service_name}"

    service = CallService::CallService.get_service service_name
    return not_found if service.nil?

    service_call_id = service.get_service_call_id_from_payload params
    voicemail_url = service.get_voicemail_url_from_payload params

    Call.end_on_voicemail call_id, service_call_id, voicemail_url

    head :ok
  end

  def hangup
    service_name = params[:service]

    logger.info "#{LOG_PREFIX} [Call] status: hangup received | service: #{service_name}"

    service = CallService::CallService.get_service service_name
    return not_found if service.nil?

    service_call_id = service.get_service_call_id_from_payload params

    Call.end_on_hangup service_call_id

    head :ok
  end

  private
    def not_found
      logger.error "#{LOG_PREFIX} [Call] Wrong service call"
      head :not_found
    end
end
