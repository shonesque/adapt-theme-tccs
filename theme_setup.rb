require 'zip'
Zip.default_compression = Zlib::BEST_COMPRESSION

ZIP_FILE_NAME = 'adapt-theme-tccs.zip'.freeze

File.delete(ZIP_FILE_NAME) if File.exist?(ZIP_FILE_NAME)

Zip::File.open(ZIP_FILE_NAME, Zip::File::CREATE) do |zip_file|
  %w[assets fonts js less templates].each do |folder|
    Dir[File.join(folder, '*')].each { |item| zip_file.add(File.join('tccs', item), item) }
  end
  %w[.bowerrc bower.json example.json LICENSE properties.schema README.md selection.json theme.json].each do |file|
    zip_file.add(File.join('tccs', file), file)
  end
end
