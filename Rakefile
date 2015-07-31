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

task :publish => directory("tumblelog/_posts") do |t, args|
  drafts = FileList["tumblelog/_drafts/*"].map {|p| Pathname.new(p) }
  drafts.keep_if {|draft| args.to_a.include? draft.basename(draft.extname).to_s } unless args.to_a.empty?
  drafts.each do |draft|
    sh %Q<mv #{draft.to_path} tumblelog/_posts/#{Date.today.iso8601}-#{draft.basename}>
  end
end

__END__
#!/bin/sh

while read local_ref local_sha remote_ref remote_sha
do
  changes=`git diff --name-only $local_sha $remote_sha | grep '^tumblelog'`
  if [ -n "$changes" ]
  then
    echo "$changes"
    bundle exec jekyll build
  fi
done
