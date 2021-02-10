
class Genre
    extend Concerns::Findable
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

    def self.create(genre1)
        genre1 = self.new(genre1)
        genre1.save
        genre1
    end

    def songs
        Song.all.each do |song|
            if song.genre == self
                @@all
            else
                @@all << self
            end
        end
        @@all
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
        end
    end

    def artists
        array = []
        Song.all.each do |song|
            if song.genre == self
                array << song
            end
        end
        array2 = []
        array.each do |song|
            array2 << song.artist
        end
        array2.uniq 
    end

end