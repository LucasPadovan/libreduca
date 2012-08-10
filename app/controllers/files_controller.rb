class FilesController < ApplicationController
  before_filter :authenticate_user!
  
  def download
    file = (PRIVATE_PATH + params[:path].to_s).expand_path

    if safe_file_path?(file)
      mime_type = Mime::Type.lookup_by_extension(File.extname(file)[1..-1])
      
      response.headers['Last-Modified'] = File.mtime(file).httpdate
      response.headers['Cache-Control'] = 'private, no-store'

      send_file file, type: (mime_type || 'application/octet-stream')
    else
      redirect_to root_url, notice: t('view.documents.non_existent')
    end
  end

  private

  def safe_file_path?(file)
    allowed_root_path = current_school ?
      PRIVATE_PATH + current_school.identification : PRIVATE_PATH

    file.exist? && file.file? && file.to_s.start_with?(allowed_root_path.to_s)
  end
end