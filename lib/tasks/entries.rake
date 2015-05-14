namespace :entries do
  desc 'Entries related tasks'

  def bare_string s
    return s.sub(/['-*]/, "").strip
  end

  # Searching for 2 or more entries with the same title/description
  # but different ids and removing one or more.
  task remove_dups: :environment do
    puts "Removing duplicate entries"
    valid_entry_array_map = [{id: 0, title: "", description: ""}]  # The list of checked entries
    entry_array_map = []        # The list of unchecked entries
    duplicate_ids = []          # Arary of duplicate pairs

    # Generate an array of maps of these to use more clearly
    Entry.pluck(:id, :title, :description).each do |entry|
      entry_hash = {
        id: entry[0],
        title: entry[1],
        description: entry[2]
      }
      entry_array_map.push(entry_hash)

      if entry_hash[:description] == "" || entry_hash[:description] == "No description"
        puts entry_hash[:id]
        #Duplicate entries rollback here!!
        Entry.find(entry_hash[:id]).update!(description: "No Description")
      end
    end

    entry_array_map.each do |entry|
      # If there is an item in the valid_entry_array_map with the same title/description
      # mark down the ids of the two
      add = true
      valid_entry_array_map.each do |valid_entry|
        if(bare_string(valid_entry[:description]) == bare_string(entry[:description])) &&
          (valid_entry[:title].strip == entry[:title].strip)
          puts valid_entry[:id]
          puts entry[:id]
          puts "\n"
          duplicate_ids.push([valid_entry[:id], entry[:id]])
          add = false
        end
      end
      if add then valid_entry_array_map.push(entry) end
      # puts entry
      # puts valid_entry_array_map
      # puts "\n"
    end

    puts "Finished, duplicate ids:"
    duplicate_ids.each do |dup|
      puts "Dups: " + dup[0].to_s + ", " + dup[1].to_s
    end
  end
end
