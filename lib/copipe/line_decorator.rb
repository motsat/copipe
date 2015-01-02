module Copipe
  class LineDecorator
    def self.decoration(line:line, index:index, current_index: current_index)
      mark = if current_index == index
               "\e[33m" +  " > "
             elsif current_index > index
               "\e[34m" + " o "
             else
               "\e[37m" +  "   "
             end
      ret =  "["+ mark + "\e[0m" + "]"
      ret + line.command
    end

    def confirm_y_or_no
      puts "\nexecute? y or n\n"
      puts "current dir ="  + Dir.pwd
      str = STDIN.gets.chomp
      case str
      when 'n'
        puts 'cancel'
        exit
      end
    end

    def commands_apply_set_value(key: , value:)
      $commands.each_with_index do |command, i|
        next unless $commands[i][:exec]
        $commands[i][:exec] = $commands[i][:exec].gsub("$#{key}", value)
      end
    end

    def next_exec_index(current_index:)
      index = $commands[current_index..-1].find_index {|c|c[:exec] != nil}
      index + current_index
    end

    #$commands.each_with_index do |command, index|

    #  # 最初か前回にコマンド実行したなら(ディレクトリ移動だけでない)コマンド一覧再表示
    #  if index == 0 || $commands[index - 1][:exec]
    #    show_commands_progress index: (next_exec_index current_index: index)
    #  end

    #  Dir.chdir command[:chdir] if command[:chdir]

    #  next unless command[:exec]

    #  unless command[:confirm] == false
    #    confirm_y_or_no
    #  else
    #    puts "current dir ="  + Dir.pwd
    #  end

    #  if command[:set]
    #    out = `#{command[:exec]}`.chomp
    #    commands_apply_set_value(key:command[:set], value:out)
    #  else
    #    system command[:exec]
    #  end
    #end
  end
end

