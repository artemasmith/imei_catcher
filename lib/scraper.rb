class Scraper

  def self.check_imei imei
    if imei.match(/\D/) || imei.length < 15
      return raise 'wrong imei'
    end
  end

  def self.get_support_period imei
    check_imei imei
    uri = URI.parse('https://selfsolve.apple.com')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new("/wcResults.do")
    request.add_field('Content-Type', 'application/x-www-form-urlencoded')
    request.body = "sn=#{imei}&cn=&locale=&caller=&num=#{rand(6000)}"
    response = http.request(request)

    status = ''
    status = 'Expired' if response.body.match("'Telephone Technical Support: Expired'")
    status = 'Active' if response.body.match("'Telephone Technical Support: Active'")
    end_period = ''
    if status == 'Active'
      date_index = response.body.index('Expiration Date:')
      end_period = response.body[date_index..date_index + 250]
      puts end_period
      end_period = end_period.match(/\w{3,10}\s{1,2}\d{1,2},\s{1,2}\d{4}/).to_s

    end
    return status, end_period
  end

end