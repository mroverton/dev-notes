

class StringColor
    def self.black(s)  ;"\e[30m#{s}\e[0m"; end
    def self.red(s)    ;"\e[31m#{s}\e[0m"; end
    def self.green(s)  ;"\e[32m#{s}\e[0m"; end
    def self.brown(s)  ;"\e[33m#{s}\e[0m"; end
    def self.blue(s)   ;"\e[34m#{s}\e[0m"; end
    def self.magenta(s);"\e[35m#{s}\e[0m"; end
    def self.cyan(s)   ;"\e[36m#{s}\e[0m"; end
    def self.gray(s)   ;"\e[37m#{s}\e[0m"; end

    def self.bg_black(s)  ;"\e[40m#{s}\e[0m"; end
    def self.bg_red(s)    ;"\e[41m#{s}\e[0m"; end
    def self.bg_green(s)  ;"\e[42m#{s}\e[0m"; end
    def self.bg_brown(s)  ;"\e[43m#{s}\e[0m"; end
    def self.bg_blue(s)   ;"\e[44m#{s}\e[0m"; end
    def self.bg_magenta(s);"\e[45m#{s}\e[0m"; end
    def self.bg_cyan(s)   ;"\e[46m#{s}\e[0m"; end
    def self.bg_gray(s)   ;"\e[47m#{s}\e[0m"; end

    def self.bold(s)         ;"\e[1m#{s}\e[22m"; end
    def self.italic(s)       ;"\e[3m#{s}\e[23m"; end
    def self.underline(s)    ;"\e[4m#{s}\e[24m"; end
    def self.blink(s)        ;"\e[5m#{s}\e[25m"; end
    def self.reverse_color(s);"\e[7m#{s}\e[27m"; end

    def self.colorize(offset, str)
        off = (offset == 0)? 0: (offset - 1)
        bold(method(COLORS[ off % COLORS.length ]).call(str))
    end
    COLORS = [
        :green,
        :brown,
        :blue,
        :magenta,
        :cyan,
        :gray
    ]
end
