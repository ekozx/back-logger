namespace :entries do
  desc 'Entries related tasks'

  def bare s
    return s.gsub(/[-()'*,.]/, "").strip.downcase
  end

  # Searching for 2 or more entries with the same title/description
  # but different ids and removing one or more.
  task remove_dups: :environment do
    valid_entry_array_map = [{id: 0, title: "", description: ""}]  # The list of checked entries
    entry_array_map = []        # The list of unchecked entries
    duplicate_ids = []          # Arary of duplicate pairs

    puts "Generate an array of maps of these to use more clearly"
    Entry.pluck(:id, :title, :description).each do |entry|
      entry_hash = {
        id: entry[0],
        title: entry[1],
        description: entry[2]
      }
      entry_array_map.push(entry_hash)

      #small fix for no description entries
      if entry_hash[:description] == "" || entry_hash[:description].strip == "No description"
        #Duplicate entries rollback here!!
        dups = Entry.where('id != ?', entry_hash[:id]).where(
          title: entry_hash[:title]
          )
        if dups.count > 0
          dups.destroy_all
        else
          Entry.find(entry_hash[:id]).update!(description: "No Description")
        end
      end
    end
    puts "entry_array_map:"
    puts entry_array_map
    puts "searching for duplicates"
    entry_array_map.each do |entry|
      # If there is an item in the valid_entry_array_map with the same title/description
      # mark down the ids of the two
      add = true
      valid_entry_array_map.each do |valid_entry|
        if(bare(valid_entry[:description]) == bare(entry[:description])) &&
          (valid_entry[:title].strip == entry[:title].strip)
          duplicate_ids.push([valid_entry[:id], entry[:id]])
          add = false
        end
      end
      if add then valid_entry_array_map.push(entry) end
    end

    puts "Finished, duplicate ids:"
    duplicate_ids.each do |dup|
      puts "Dups: " + dup[0].to_s + ", " + dup[1].to_s
      Entry.destroy(dup[0])
    end
  end
end
