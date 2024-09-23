require 'thor'
require 'time'

# class that generates a template blogpost
class GenerateBlogPost < Thor
  desc 'generate', "Generate a blog post: generate NAME[my-awesome-post] DATE[yyyy-mm-dd] if date is nil will use today's"
  option :name, type: :string, default: 'no-name-blog'
  option :date, type: :string, default: Time.now.strftime('%Y-%m-%d')

  def generate
    return help('generate') unless valid_name?
    return help('generate') unless valid_date?

    date = options[:date]
    file_name = options[:name] ? "#{date}-#{options[:name]}" : "#{date}-no-name-blog"
    create_file(date, file_name, options[:name])
    puts "Created the file #{file_name} in folder _posts"
  rescue ArgumentError
    help('generate')
  end

  private

  def valid_name?
    return false unless options[:name].match('^[a-zA-Z0-9]+(-[a-zA-Z0-9]+)*$')
    true
  end

  def valid_date?
    return true if Time.parse(options[:date]) &&
      Time.parse(options[:date]).strftime('%Y-%m-%d') == options[:date]
    false
  end

  def create_file(date, file_name, name)
    File.open("_posts/#{file_name}.md", 'w') do |f|
      f.write template(date, name)
    end
  end

  def template(date, name)
    <<~TEMP
      ---
      layout: post
      author: Wildeng
      2024: #{date}
      title: #{name.gsub('-', ' ').capitalize}
      ---

      ---

      #### Things I like - in random order ####

      <br/>
      <img src="" alt="" class="post-image"/>
      <br/>
      <br/>
      <img src="" alt="" class="post-image">
      <br/>
      <br/>

      ---

      #### Today's Links ####

    TEMP
  end
end

GenerateBlogPost.start(ARGV)
