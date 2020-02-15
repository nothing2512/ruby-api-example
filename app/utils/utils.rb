class Utils < Constants
  def self.is_email(email)
    if email.to_s.match /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      true
    else
      false
    end
  end

  def self.is_numeric(data)
    if data.to_s.match /[0-9]/i
      true
    else
      false
    end
  end

  def self.is_between(data, min, max)
    data.to_s.length <= max and data.to_s.length >= min
  end

  def self.upload(photo)

    now = DateTime.now
    ext = photo.original_filename.split(".").last
    filename = now.strftime("%Y%m%d%H%M%s") + "." + ext

    unless Dir.exist? IMAGE_DIR
      Dir.mkdir IMAGE_DIR
    end

    File.open(File.join(IMAGE_DIR, filename), "wb") do |file|
      file.write(photo.tempfile.read)
    end

    filename
  end

  def self.encrypt(password)
    delimiter = Digest::MD5.hexdigest SALT
    data = SALT + delimiter + password
    Digest::MD5.hexdigest data
  end
end