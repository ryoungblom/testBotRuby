require 'telegram_bot'
require 'telegram/bot'

token = '607276785:AAFhORYYd-_VBiztLFEP2LmbIPY8R5cDSJQ'


Telegram::Bot::Client.run(token) do |bot|

bot.listen do |message|




  case message.text
  when '/test'
    question = 'Hello, what would you like to do?'
    # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Rate Help), %w(Ratings Goodbye)], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
  when /Rate/i
    question = 'Great!  Would you like to be a lead or a jurist?'
    # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Lead Jurist), %w(Help Back)], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)
  when '/stop'
    # See more: https://core.telegram.org/bots/api#replykeyboardremove
    kb = Telegram::Bot::Types::ReplyKeyboardRemove.new(remove_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: 'Sorry to see you go :(', reply_markup: kb)

  when /Jurist/i
    question = 'Fantastic! Please rate the following arguments:'
    # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Great Decent), %w(Mediocre Bad)], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

  when /Lead/i
    question = 'Excellent. Your token is: NEO. Please upload your brief by 23:59 on 8/21/18!'
    # See more: https://core.telegram.org/bots/api#replykeyboardmarkup
    answers =
      Telegram::Bot::Types::ReplyKeyboardMarkup
      .new(keyboard: [%w(Upload Help)], one_time_keyboard: true)
    bot.api.send_message(chat_id: message.chat.id, text: question, reply_markup: answers)

  when /do/i
    bot.api.send_message(chat_id: message.chat.id, text: "So far, I just say Hi! Try the /greet command.", reply_markup: answers)
  when /Help/i
    bot.api.send_message(chat_id: message.chat.id, text: "please visit www.veva.one for help!")
  when /Goodbye/i
    bot.api.send_message(chat_id: message.chat.id, text: "Goodbye!")
  when /Ratings/i
    ratings = "Bitcoin: 6.5;\nEthereum: 7.1;\nRipple: 4.4;\nBitcoin Cash: 3.0;\nEOS: 5.0"
    bot.api.send_message(chat_id: message.chat.id, text: ratings)
  when /greet/i
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}", reply_markup: answers)
  when /veva/i
    bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}.  Welcome to the VEVA sandbox.  What would you like to do?", reply_markup: answers)

  else
    bot.api.send_message(chat_id: message.chat.id, text: "I have no idea what that means...", reply_markup: answers)
  end

  end

end


=begin
bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)


  message.reply do |reply|
    case command
    when /start/i
      reply.text = "So far, I just say Hi! Try the /greet command."
    when /greet/i
      reply.text = "Hello, #{message.from.first_name}"
      Telegram::Bot::Types::KeyboardButton.new(text: 'Show me your location', request_location: true)
    when /test/i
      reply.text = "Hello, #{message.from.first_name}.  Welcome to the VEVA sandbox.  What would you like to do?"
    else
      reply.text = "I have no idea what #{command.inspect} means..."
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)

  end
end

=end
