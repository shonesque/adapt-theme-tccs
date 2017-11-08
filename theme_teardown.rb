require 'fileutils'
require 'pathname'
require 'mongo'

DATABASE_NAME = "adapt-tenant-master"
THEME_NAME = "adapt-theme-tccs"

puts "Deleting plugin theme dir"

PLUGIN_THEME_DIR = "../adapt_authoring/plugins/content/theme/versions/#{THEME_NAME}"

FileUtils.rm_rf(PLUGIN_THEME_DIR)

puts "Deleted plugin theme dir"


puts "Deleting temp theme dir"

TEMP_DIR = "../adapt_authoring/temp"
TEMP_DIR_NAME = Pathname.new(TEMP_DIR).children.select { |c| c.directory? }.first { |p| p.to_s }
TEMP_THEME_DIR = "#{TEMP_DIR_NAME}/adapt_framework/src/theme/#{THEME_NAME}"

FileUtils.rm_rf(TEMP_THEME_DIR)

puts "Deleted temp theme dir"

puts "Deleting Mongodb collection reference"

client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => "#{DATABASE_NAME}")
db = client.database

collection = client[:themetypes]

result = collection.delete_one( { name: "#{THEME_NAME}" } )

puts result.deleted_count

puts "Deleted Mongodb collection reference"





