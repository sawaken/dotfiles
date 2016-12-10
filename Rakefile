# encoding: utf-8

# Basenames of all dotfiles in ./deployed/
BASENAMES = Dir.glob('./deployed/.*[^~#.]').map { |f| File.basename(f) }
# Basenames of all dotfiles in $HOME
BASENAMES_HOME = Dir.glob("#{ENV['HOME']}/.*[^~#.]").map { |f| File.basename(f) }
# linking .bat filename
LINK_BAT_FILENAME = 'link.bat'

# dotfile's full-path
# ----------

def home(basename)
  ENV['HOME'] + '/' + basename
end

def original(basename)
  File.expand_path("./deployed/#{basename}")
end

def win_home(basename)
  File.expand_path("../#{basename}")
end

# dotfile's status
# ----------

def linked_to_me?(basename)
  File.exist?(home(basename)) && File.symlink?(home(basename)) &&
    `readlink #{home(basename)}`.chomp == original(basename)
end

def linked_to_others?(basename)
  File.exist?(home(basename)) && File.symlink?(home(basename)) &&
    `readlink #{home(basename)}`.chomp != original(basename)
end

def linked_to_nonexistence?(basename)
  !File.exist?(home(basename)) && File.symlink?(home(basename))
end

def entity?(basename)
  File.exist?(home(basename)) && !File.symlink?(home(basename))
end

def empty?(basename)
  !File.exist?(home(basename)) && !File.symlink?(home(basename))
end

desc './deployed/に存在する全てのdotfileのリンクを張る'
task 'link' do
  BASENAMES.each do |basename|
    symlink(original(basename), home(basename)) if empty?(basename)
  end
end

desc './deployed/に存在する全てのdotfileのリンクを切る'
task 'unlink' do
  BASENAMES.each do |basename|
    rm home(basename) if linked_to_me?(basename)
  end
end

desc "#{ENV['HOME']}/に存在する全てのdotfileの内、broken-linkであるものを削除する"
task 'clean' do
  BASENAMES_HOME.each do |basename|
    rm home(basename) if linked_to_nonexistence?(basename)
  end
end

desc './deployed/に存在する全てのdotfileのリンク状態を表示する'
task 'status' do
  s = proc { |&b| BASENAMES.select(&b).each { |n| puts "  ./deployed/#{n}" } }
  puts 'linked:'
  s.call { |n| linked_to_me?(n) }
  puts 'unlinked:'
  s.call { |n| empty?(n) }
  puts 'unlinkable:'
  s.call { |n| linked_to_others?(n) || linked_to_nonexistence?(n) || entity?(n) }
end

desc 'Windowsでリンクを張るためのBATファイルを生成する'
task 'generate-link-bat' do
  File.open("./#{LINK_BAT_FILENAME}", 'w') do |f|
    f.puts 'rem 管理者権限で実行すること'
    BASENAMES.each do |basename|
      if File.exist?(win_home(basename))
        f.puts "rem #{basename} is skipped"
      else
        opt = File.directory?(original(basename)) ? ' /D' : ''
        f.puts "mklink#{opt} \"#{win_home(basename)}\" \"#{original(basename)}\""
      end
    end
  end
  puts "#{LINK_BAT_FILENAME} is generated"
end
