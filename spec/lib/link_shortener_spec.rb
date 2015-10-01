describe LinkShortener do

  describe '.clean_url' do
    it 'prepends protocol if missing' do
      cleaned_url = LinkShortener.clean_url("google.com")
      expect(cleaned_url).to eq "http://google.com/"
    end

    it 'does nothing if protocol included' do
      cleaned_url = LinkShortener.clean_url("http://google.com")
      expect(cleaned_url).to eq "http://google.com/"
    end
  end

  describe '.generate' do
    it 'generates a token' do
      token = LinkShortener.generate
      expect(token.length).to eq LinkShortener.token_length
    end

    it 'generates a 10-char token' do
      token = LinkShortener.generate(10)
      expect(token.length).to eq 10
    end
  end

  describe '.sanitize' do
    it 'removes BAD WORDS from a token' do
      dirty_token = LinkShortener::BAD_WORDS.join
      sanitized_token = LinkShortener.sanitize(dirty_token)

      expect(dirty_token).not_to eq sanitized_token
      expect(dirty_token.length).to eq sanitized_token.length
      expect(sanitized_token).not_to include(*LinkShortener::BAD_WORDS)
    end
  end

end