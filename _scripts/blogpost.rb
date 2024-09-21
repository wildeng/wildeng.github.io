require 'thor'
require 'time'

# class that generates a template blogpost
class GenerateBlogPost < Thor
  desc 'Generate a blog post', "generate NAME[my-awesome-post] DATE[yyyymmdd] if date is nil will use today's"

  def generate(name = nil, date = nil)
    date ||= Time.now.strftime('%Y-%m-%d')
    file_name = name ? "#{date}-#{name}" : "#{date}-no-name-blog"
    create_file(date, file_name, name)
    puts "Created the file #{file_name} in folder _posts"
  end

  private

  def create_file(date, file_name, name)
    File.open("../_posts/#{file_name}.md", 'w') do |f|
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
