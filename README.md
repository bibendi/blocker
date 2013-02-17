# Blocker

Установка "мьютекса" в редисе для синхронных операций.

## Usage

Можно пользоваться магическими методами, например:

    Blocker.lock_my_sync do
      your code
    end

Также, есть такие методы, из названий понятно что они делают:

    Blocker.unlock_my_synk
    Blocker.my_synk_locked?
    Blocker.lock(:my_synk)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
