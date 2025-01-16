if defined?(Faraday::Error::ConnectionFailed)
  Faraday::Error::ConnectionFailed = Faraday::ConnectionFailed
end
