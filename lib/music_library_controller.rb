
class MusicLibraryController
    attr_accessor :path
       
    def initialize(path = './db/mp3s')
        new1 = MusicImporter.new(path)
        new1.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        
        loop do
            args = ['list songs', 'list artists', 'list genres', 'list artist', 'list genre', 'play song', 'exit']
            puts "What would you like to do?"
            input = gets.chomp
        
            if input == args[0]
                self.list_songs
            elsif input == args[1]
                self.list_artists
            elsif input == args[2]
                self.list_genres
            elsif input == args[3]
                self.list_songs_by_artist
            elsif input ==  args[4]
                self.list_songs_by_genre
            elsif input == args[5]
                self.play_song
            elsif input == "exit"
                break
            end
        end
    end

    def list_songs
        sorted = Song.all.sort_by{ |song| song.name }
        sorted = sorted.uniq
        # binding.pry
        i = 1
        sorted.each do |song|
            puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            i += 1
        end
    end

    def list_artists
        sorted_list = Artist.all
        sorted_list = sorted_list.sort_by { |song| song.name }
        # binding.pry
        i = 1
        sorted_list.each do |artist|
            puts "#{i}. #{artist.name}"
            i += 1
        end
    end

    def list_genres
        sorted_list = Song.all
        sorted_list = sorted_list.sort_by { |song| song.genre.name }
        sorted_list = sorted_list.uniq(&:genre)
        i = 1
        sorted_list.each do |genre|
            puts "#{i}. #{genre.genre.name}"
            i += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        this_artist = Artist.find_by_name(input)
        if this_artist != nil
            i = 1
            sorted = Song.all.sort_by { |song| song.name }
            sorted = sorted.uniq
            sorted.each do |song|
                if song.artist == this_artist
                puts "#{i}. #{song.name} - #{song.genre.name}"
                i += 1
                end
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp
        this_genre = Genre.find_by_name(input)
        if this_genre != nil
            i = 1
            sorted = Song.all.sort_by { |song| song.name }
            sorted = sorted.uniq
            # binding.pry
            sorted.each do |song|
                if song.genre == this_genre
                puts "#{i}. #{song.artist.name} - #{song.name}"
                i += 1
                end
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp
        input = input.to_i
        sorted = Song.all.sort_by{ |song| song.name }
        sorted = sorted.uniq
        # binding.pry
        if input > 0 && input <= sorted.length
            puts "Playing #{sorted[input - 1].name} by #{sorted[input - 1].artist.name}"
        end
    end
    

end


