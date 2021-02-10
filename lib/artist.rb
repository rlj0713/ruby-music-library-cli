
class Artist
    extend Concerns::Findable  #inherits methods for class 
    # include Name    #inherits methods for instances of the class
    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        artist1 = self.new(name)
        artist1.save
        artist1
    end

    def songs
        Song.all.each { |song| song.artist == self ? @songs << song : next }
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
            @@all << song
        end
    end

    def genres
        array = []
        Song.all.each do |song|
            if song.artist == self
                array << song
            end
        end
        array2 = []
        array.each do |song|
            array2 << song.genre
        end
        array2.uniq 
    end

end