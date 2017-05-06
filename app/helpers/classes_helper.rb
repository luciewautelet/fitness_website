module ClassesHelper
    def def_class_start the_class
        @classes = Classe.all
        @day  = nil
        @month = nil
        @year = nil
        @classes.each do |cl|
            if (the_class.start == true && cl.start == true && the_class.ctype == cl.ctype)
                if (@year && @year >= cl.date.to_time.strftime("%y"))
                    if (@month >= cl.date.to_time.strftime("%m"))
                        if (@day > cl.date.to_time.strftime("%d"))
                            @year = cl.date.to_time.strftime("%Y")
                            @month = cl.date.to_time.strftime("%m")
                            @day = cl.date.to_time.strftime("%d")
                        end
                    end
                elsif (!@year)
                    @year = cl.date.to_time.strftime("%Y")
                    @month = cl.date.to_time.strftime("%m")
                    @day = cl.date.to_time.strftime("%d")
                end
            end
        end
        if (!@day)
            return ""
        else
            return Date.new(@year.to_i, @month.to_i, @day.to_i)
        end
    end
    
    def get_prev days
        i = 0

        while (i < 7)
            if days[i][1] != ""
                print "heyyy"

                tmp = "2017-" + days[i][1] + "-" + days[i][2]
                print tmp
                prev = Date.strptime(tmp, "%Y-%d-%m")
                prev = prev - (7 + i)
                return prev;
            end
            i += 1
        end
        prev = Date.(Date.new("2017", days[0][2], days[0][1]) - 7)
        print "hello" + prev
        return prev;
        
    end
    
    def is_today days
        days.each do |da|
            if da[1] == Date.today.strftime("%d") && da[2] == Date.today.strftime("%m")
                return true
            end
        end
        return false
    end
end

