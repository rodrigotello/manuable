require 'httpclient'
require 'fileutils'

class BanwireOxxo
  attr_accessor :referencia, :dias_vigencia, :monto, :url_respuesta, :cliente, :email, :sendPDF, :usuario, :format

  def initialize params={}
    params.slice(:referencia, :dias_vigencia, :monto, :url_respuesta, :cliente, :email, :sendPDF, :usuario, :format).each do |k,v|
      send("#{k}=", v)
    end
  end

  def ready?
    referencia.present? &&
    dias_vigencia.present? &&
    monto.present? &&
    url_respuesta.present? &&
    cliente.present? &&
    email.present? &&
    sendPDF.present? &&
    usuario.present? &&
    format.present?
  end

  def send!
    # raise 'Not ready yet' unless ready?
    @response = {}
    CGI.parse(HTTPClient.post('https://www.banwire.com/api.oxxo', {
        referencia: referencia,
        dias_vigencia: dias_vigencia,
        monto: monto,
        url_respuesta: url_respuesta,
        cliente: cliente,
        email: email,
        sendPDF: sendPDF,
        usuario: usuario,
        format: format
        }).body).each { |k,v| @response[k] = v.first }
    @response
  end

  def successful?
    raise 'no performed yet' unless !@response.nil?
    @response["error"] == "0"
  end

  def response
    @response
  end

  def errors
    @response["error_msg"]
  end

  def store_barcode filepath
    raise 'no performed yet' unless !@response.nil?

    FileUtils.mkpath File.join(filepath)

    File.open(File.join(filepath, "#{referencia}.gif"), 'wb') do|f|
      f.write(Base64.decode64(@response['response[barcode_img]']))
    end
  end
end

# {"error"=>"0",
# "response[barcode_img]"=>"iVBORw0KGgoAAAANSUhEUgAAASwAAABOAQMAAACg+LnTAAAABlBMVEX///8AAABVwtN+AAABIklEQVRIiWP4Twz4wNDAQAQQGFVGkTLG4LCw1Kkpl6NmRflO2rItCsjLmZoWuiljVNmoslFlo8pGlY0qo5cyAmBglbE38UhwCHz8+cD5MBM/j41ARcKBh83MbPZoyjjchFQkDDmZBI6otAlMcjJomajI5NLSyYiuzEvRSSOQk0nQRcNLYKFTQCuXEIuGR0AjutucFJ04BDmZhBw0nBgWOgmwQpQ1oSljbAIqE/j58YnDCSd2RRsBSS7hJ1iUMTGBlHFwiThygE1T5BISwaKMBapM/BFEmSNEWQu6F6DKBFw4nIBeEGjEpUxIhUNAEKiMpQkYIAINE5WEgAHCgqaM/3yPhF3Ng48P3B/z9/PY1PxJOAgKXnRlREbWqDLaKCOu6Q4AVcSMX4xGR9MAAAAASUVORK5CYII=",
# "response[barcode]"=>"21001195842013081200600007",
# "response[referencia]"=>"18",
# "response[fecha_vigencia]"=>"2013-08-12",
# "response[monto]"=>"600.00"}
