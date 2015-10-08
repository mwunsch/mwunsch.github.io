require 'jekyll'
require 'fileutils'
require 'rake/clean'
require 'pathname'

JEKYLL_CONFIGURATION = Jekyll.configuration({})
JEKYLL_DESTINATION = JEKYLL_CONFIGURATION["destination"]

task default: [:install, JEKYLL_DESTINATION]

desc 'Build jekyll'
task :build do |t|
  sh %q(jekyll build)
end

file JEKYLL_DESTINATION => [:build]
CLEAN << JEKYLL_DESTINATION

file ".git/hooks/pre-push" => directory(".git/hooks") do |t|
  File.open(t.name, "w", 0755) do |f|
    f.puts File.read(__FILE__).split(/^__END__$/, 2)[1].strip
  end
end
CLOBBER << ".git/hooks/pre-push"

desc 'Install pre-push hook'
task install: [".git/hooks/pre-push"]

namespace :publish do
  directory "tumblelog/_posts"
  directory "tinyletter/_posts"

  desc 'Publish a tumblelog draft post; accepts a slug as an optional arg'
  task :tumblelog => "tumblelog/_posts" do |t, args|
    drafts = FileList["tumblelog/_drafts/*"].map {|p| Pathname.new(p) }
    drafts.keep_if {|draft| args.to_a.include? draft.basename(draft.extname).to_s } unless args.to_a.empty?
    drafts.each do |draft|
      sh %Q<mv #{draft.to_path} tumblelog/_posts/#{Date.today.iso8601}-#{draft.basename}>
    end
  end

  desc 'Publish a tinyletter draft post; accepts a slug as an optional arg'
  task :tinyletter => "tinyletter/_posts" do |t, args|
    drafts = FileList["tinyletter/_drafts/*"].map {|p| Pathname.new(p) }
    drafts.keep_if {|draft| args.to_a.include? draft.basename(draft.extname).to_s } unless args.to_a.empty?
    drafts.each do |draft|
      sh %Q<mv #{draft.to_path} tinyletter/_posts/#{Date.today.iso8601}-#{draft.basename}>
    end
  end
end

desc "Publish draft posts by moving them into the '_posts' dir"
task :publish => ['publish:tumblelog','publish:tinyletter']

__END__
#!/bin/sh

while read local_ref local_sha remote_ref remote_sha
do
  changes=`git diff --name-only $local_sha $remote_sha | grep -e '^tumblelog' -e '^tinyletter'`
  if [ -n "$changes" ]
  then
    echo "$changes"
    bundle exec jekyll build
  fi
done
