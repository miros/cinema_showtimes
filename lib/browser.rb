class Browser

  DEFAULT_HEADERS = {
    'User-Agent' => 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.19) Gecko/2010040116 Ubuntu/9.04 (jaunty) Firefox/3.0.19 FirePHP/0.4',
    'Accept-Charset' => 'UTF-8,*'
  }

  def initialize(headers = {})
    init_headers(headers)
  end

  def init_headers(headers)
    @headers = DEFAULT_HEADERS.merge(headers) 
  end

  def referer=(url)
    @headers['Referer'] = url 
  end

  def get(url)
    params = @headers.merge({
      :proxy => APP_CONFIG['proxy']        
    })
    open(url, params).read
  end

end