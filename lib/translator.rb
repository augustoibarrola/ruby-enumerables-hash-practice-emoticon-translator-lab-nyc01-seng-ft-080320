require 'pry'
require 'yaml'

def load_library(emoticons)
emoticons = YAML.load(File.open("lib/emoticons.yml"))
emo_hash = Hash.new
little_faces = Hash.new
little_faces_meaning = Hash.new
little_faces_meaning = emoticons.keys
little_faces = emoticons.values
language_keys = [:english, :japanese]
language_keys_faces = little_faces.collect do |x|
                        language_keys.zip(x)
                      end
language_keys_faces_two = language_keys_faces.collect do |x|
                        x.to_h
                      end
emo_hash = little_faces_meaning.zip(language_keys_faces_two).to_h
emo_hash
end

def sorry_message
   "Sorry, that emoticon was not found"
end


def get_japanese_emoticon(yaml_file, emoticon)
  emoticon_set = load_library("./lib/emoticons.yml")
  emoticons_array = Array.new
  emoticons_hash = Hash.new
  emoticon_set.each do |moods, mood_hashes|
    emoticons_array << mood_hashes.values
  end
  emoticons_hash = Hash[emoticons_array]
  if emoticons_hash.member? emoticon
   emoticons_hash.invert.key(emoticon)
   else
     sorry_message
   end
end


def get_english_meaning(yaml_file, emoticon)
  emoticon_set = load_library("./lib/emoticons.yml")
  emoticons_array = Array.new
  what_is_this_feeling = Array.new
  emoticons_hash = Hash.new
  emoticon_set.each do |moods, mood_hashes|
    emoticons_array << mood_hashes.values.flatten
    what_is_this_feeling << moods
  end
  together_now = what_is_this_feeling.zip(emoticons_array)
  key = Array.new
  together_now.map do |x|
    if x.flatten.member? emoticon
      key = x
    end
  end
  key = key.first
  if together_now.flatten.include? emoticon
    key
  else
    sorry_message
  end
end
