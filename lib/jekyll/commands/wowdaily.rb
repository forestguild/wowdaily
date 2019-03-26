require "nokogiri"
require "open-uri"
require "yaml"
module Jekyll
    module Commands
        class Wowdaily < Command
            class << self
                def getFactionByCss(css_class)
                    case css_class
                    when "icon-horde"
                        return "horde"
                    when "icon-alliance"
                        return "alliance"
                    else
                        return "horde-alliance"
                    end
                end
                def init_with_program(prog)
                    prog.command(:wowdaily) do |c|
                        c.syntax "wowdaily [options]"
                        c.option "region", "--region REGION", "Region code, eg: eu"
                        c.option "lang", "--lang LANG", "Language code, eg: ru, en"
                        c.description "Grab WoW Daily info from wowhead"
                        c.action do |args, options|
                            # Options
                            options = getConfig(options)
                            # Init empty
                            worldboss = {}
                            wowtoken = 0
                            holidays = []
                            islandexpeditions = []
                            emissares = []

                            # Grab data
                            Jekyll.logger.info 'Grabbing data in ' + options['lang'] + ' language for ' + options['region'] + ' region...'
                            doc = Nokogiri::HTML(open("https://" + options['lang'] + ".wowhead.com/")).css(".tiw-region-" + options['region'].upcase)

                            # Parse it
                            Jekyll.logger.info "Parsing..."
                            doc.css(".tiw-group-epiceliteworldbfa").css("span").css("a").each do |a|
                                worldboss = {"name": a.text,"url": "https://" + options['lang'] + ".wowhead.com" + a.get_attribute("href")}
                            end
                            doc.css(".tiw-group-wowtoken").css(".moneygold").each do |gold|
                                wowtoken = gold.text.gsub(",","").to_i
                            end
                            doc.css(".tiw-group-holiday").css("span").css("a").each do |a|
                                holiday = {"name" => a.text,
                                           "url" => "https://" + options['lang'] + ".wowhead.com" + a.get_attribute("href"),
                                           "fraction" => getFactionByCss(a.parent.get_attribute("class"))}
                                holidays.push(holiday)
                            end
                            doc.css(".tiw-group-islandexpeditions").css("td.icon-both").css("a").each do |a|
                                expedition = {"name" => a.text, "url" => "https://" + options['lang'] + ".wowhead.com" + a.get_attribute("href")}
                                islandexpeditions.push(expedition)
                            end
                            doc.css(".tiw-group-emissary7").css("td").css("a").each do |a|
                                emissar = {"name" => a.text,
                                           "url" => "https://" + options['lang'] + ".wowhead.com" + a.get_attribute("href"),
                                           "fraction" => getFactionByCss(a.parent.get_attribute("class"))}
                                emissares.push(emissar)
                            end
                            data = {"worldboss": worldboss, "wowtoken": wowtoken,"holidays": holidays,"islandexpeditions":islandexpeditions,"emissares":emissares}

                            File.write(options['data_dir'] + "/wowdaily_" + options['lang'] + "_" + options['region'] + ".json", data.to_json)
                        end
                    end
                end
                def getConfig(options)
                    config = Jekyll.configuration({})
                    options['data_dir'] = File.expand_path(config['data_dir'])
                    ['lang', 'region'].each do |key|
                        if (config['wowdaily'].key? key) === true
                            options[key] = config['wowdaily'][key]
                        end
                    end
                    options
                end
            end
        end
    end
end
