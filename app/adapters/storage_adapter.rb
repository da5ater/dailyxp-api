# Domain interface – never imports aws-sdk
module StorageAdapter
  def self.for_env
    case ENV["STORAGE_ADAPTER"]
    when "s3" then S3Adapter.new
    else FilesystemAdapter.new
    end
  end
end
class FilesystemAdapter
  def store(key, data); File.write("/tmp/#{key}", data); end
end
class S3Adapter
  def store(key, data)
    # Only instantiated when STORAGE_ADAPTER=s3; tests stub this without loading aws-sdk
    raise "S3 not configured" unless ENV["S3_ENDPOINT"]
  end
end
