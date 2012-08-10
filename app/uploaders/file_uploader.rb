# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  storage :file
  after :remove, :delete_empty_upstream_dirs

  def store_dir
    "#{base_store_dir}/#{('%08d' % model.id).scan(/\d{4}/).join('/')}"
  end

  def base_store_dir
    school = model.school.try(:identification) || RESERVED_SUBDOMAINS.first

    "private/#{school}/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  def delete_empty_upstream_dirs
    path = ::File.expand_path(store_dir, root)
    Dir.delete(path) # fails if path not empty dir
    
    path = ::File.expand_path(base_store_dir, root)
    Dir.delete(path) # fails if path not empty dir
  rescue SystemCallError
    true # nothing, the dir is not empty
  end
end
