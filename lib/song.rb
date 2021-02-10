
class Song
    extend Concerns::Findable
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist != nil
            self.artist = artist
        end
        if genre != nil
            self.genre = genre
        end
        @@all << self
    end

    def name
        @name
    end

    def name=(name)
        @name = name
    end

    def genre
        @genre
    end

    def genre=(type)
        @genre = type
        type.add_song(self)
        if Genre.all.include?(self) == false
            Genre.all << self
        end
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
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
        song1 = self.new(name)
        song1
    end

    def self.new_from_filename(filename)
        array = filename.delete_suffix('.mp3').split(" - ")
        new_song = self.new(array[1])
        a1 = Artist.find_or_create_by_name(array[0])
        g1 = Genre.find_or_create_by_name(array[2])
        # binding.pry
        new_song.artist = a1
        new_song.genre = g1
        new_song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename).save
    end

end