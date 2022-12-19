#require "open-uri"
require "twilio-ruby"
class SMSApi
  attr_accessor :client

  #def initialize
  #  @client = Savon.client(wsdl: url)
  #end

  #def url
  #  return "" unless end_point_available?
  SID = Rails.application.secrets.sms_account_sid
  AUTH_TOKEN = Rails.application.secrets.sms_auth_token
  PHONE_NUMBER = Rails.application.secrets.sms_phone_number

  #  URI.parse(Rails.application.secrets.sms_end_point).to_s
  #end

  #def authorization
  #  Base64.encode64("#{Rails.application.secrets.sms_username}:#{Rails.application.secrets.sms_password}")
  def initialize
        @client = Twilio::REST::Client.new SID, AUTH_TOKEN
  end

  def sms_deliver(phone, code)
    return stubbed_response unless end_point_available?

    #response = client.call(:enviar_sms_simples, message: request(phone, code))
    #success?(response)
  #end
    message = @client.messages.create(
        body: "Este es el código de verificación de su teléfono: #{code}",
        from: PHONE_NUMBER,
        to: phone)
    
  #def request(phone, code)
  #  { autorizacion:  authorization,
  #    destinatarios: { destinatario: phone },
  #    texto_mensaje: "Clave para verificarte: #{code}. Gobierno Abierto",
  #    solicita_notificacion: "All" }
   success?(message) 
  end

  #def success?(response)
  #  response.body[:respuesta_sms][:respuesta_servicio_externo][:texto_respuesta] == "Success"
  #end
  
  def success?(message)
    message.error_code.blank?
  end
  
  def end_point_available?
    Rails.env.staging? || Rails.env.preproduction? || Rails.env.production?
  end

  def stubbed_response
    {
      respuesta_sms: {
        identificador_mensaje: "1234567",
        fecha_respuesta: "Thu, 20 Aug 2015 16:28:05 +0200",
        respuesta_pasarela: {
          codigo_pasarela: "0000",
          descripcion_pasarela: "Operación ejecutada correctamente."
        },
        respuesta_servicio_externo: {
          codigo_respuesta: "1000",
          texto_respuesta: "Success"
        }
      }
    }
  end
end
