if Rails.env.production?
  Geocoder.configure(
    # geocoding options
    # :timeout      => 3,           # geocoding service timeout (secs)
    :lookup       => :google_premier,     # name of geocoding service (symbol)
    # :language     => :en,         # ISO-639 language code
    :use_https    => true,       # use HTTPS for lookup requests? (if supported)
    # :http_proxy   => nil,         # HTTP proxy server (user:pass@host:port)
    # :https_proxy  => nil,         # HTTPS proxy server (user:pass@host:port)
    :api_key      => ServicesConfig.google['maps'],         # API key for geocoding service
    # :cache        => nil,         # cache object (must respond to #[], #[]=, and #keys)
    # :cache_prefix => "geocoder:", # prefix (string) to use for all cache keys

    # exceptions that should not be rescued by default
    # (if you want to implement custom error handling);
    # supports SocketError and TimeoutError
    :always_raise => [Geocoder::OverQueryLimitError,
                      Geocoder::RequestDenied,
                      Geocoder::InvalidRequest,
                      Geocoder::InvalidApiKey],

    # calculation options
    :units     => :km       # :km for kilometers or :mi for miles
    # :distances => :linear    # :spherical or :linear
  )
else
  Geocoder.configure(
    :lookup       => :google,
    :use_https    => true,
    :api_key      => nil,
    :units     => :km
  )
end
