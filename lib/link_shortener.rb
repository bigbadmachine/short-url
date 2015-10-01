module LinkShortener

	REGEX_URL_HAS_PROTOCOL = Regexp.new('\A(?:(?:https?|ftp):\/\/)', Regexp::IGNORECASE)
  REGEX_VALID_URL = Regexp.new('\A(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?\z', Regexp::IGNORECASE)

  CHARSETS = {
		# Remove all possible Transcription ambiguities
		# 1/l/I  0/O/o 
		alpha_lower: ('a'..'k').to_a + ['m', 'n'] + ('p'..'z').to_a,
		alpha_upper: ('A'..'H').to_a + ('J'..'N').to_a + ('P'..'Z').to_a,
		num: (2..9).to_a
	}

	BAD_WORDS = %w(foo bar)

  mattr_accessor :token_length
  self.token_length = 7

  mattr_accessor :default_link
  self.default_link = "/"

  def self.generate(length=token_length, chars=allowed_chars)
    sanitize( generate!(length, chars) )
  end

  def self.sanitize(token)
    sanitized_token = token
    BAD_WORDS.each do |word|
      sanitized_token = sanitized_token.gsub(/(#{word})+/){ |match| generate!(match.length, clean_chars) }
    end
    sanitized_token
  end

  def self.clean_url(url)
    _url = url.to_s.strip
    if _url !~ LinkShortener::REGEX_URL_HAS_PROTOCOL && _url[0] != '/'
      _url = "http://#{_url}"
    end
    URI.parse(_url).normalize.to_s
  end

  private

    def self.allowed_chars
      CHARSETS[:alpha_lower] + CHARSETS[:alpha_upper] + CHARSETS[:num]
    end

    def self.clean_chars
      chars = LinkShortener::BAD_WORDS.join.upcase + LinkShortener::BAD_WORDS.join.downcase
      allowed_chars - chars.chars
    end

    def self.generate!(length=token_length, chars=allowed_chars)
      (0..length-1).map{ chars[rand(chars.size)] }.join
    end
end