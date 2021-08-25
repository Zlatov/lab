require 'rails_helper'

RSpec.describe Account, type: :model do

  context "" do

  	expect(subject).to ...
    expect(subject).not_to ...

    # Идентичность объектов (if subject.equal?(expected))
    expect(subject).to be(expected)

    # Эквивалентвность объектов (if subject == expected)
    expect(subject).to eq(expected)

    # Сравнение
    expect(subject).to be >  expected
    expect(subject).to be >= expected
    expect(subject).to be <= expected
    expect(subject).to be <  expected
    expect(subject).to be_between(minimum, maximum).inclusive
    expect(subject).to be_between(minimum, maximum).exclusive
    expect(subject).to match(/expression/)
    expect(subject).to be_within(delta).of(expected)
    expect(subject).to start_with expected
    expect(subject).to end_with expected

    # Ожидание ошибок
    expect { ... }.to raise_error
    expect { ... }.to raise_error(ErrorClass)
    expect { ... }.to raise_error("message")
    expect { ... }.to raise_error(ErrorClass, "message")

    # Проверка коллекций элементов
    expect([1, 2, 3]).to     include(1)
    expect([1, 2, 3]).to     include(1, 2)
    expect(:a => 'b').to     include(:a => 'b')
    expect("this string").to include("is str")
    expect([1, 2, 3]).to     contain_exactly(2, 1, 3)
    expect([1, 2, 3]).to     match_array([3, 2, 1])

    # Наблюдение за изменениями
    expect { object.action }.to change(object, :value).from(old).to(new)
    expect { object.action }.to change(object, :value).by(delta)
    expect { object.action }.to change(object, :value).by_at_least(minimum_delta)
    expect { object.action }.to change(object, :value).by_at_most(maximum_delta)

    # Expecting throws, чо?
    expect { ... }.to throw_symbol
    expect { ... }.to throw_symbol(:symbol)
    expect { ... }.to throw_symbol(:symbol, 'value')

    # Коды ниже я бы не использовал, есть же оригинальные .present? .blank? .instance_of?

    # Types/classes/response
    expect(actual).to be_instance_of(expected)
    expect(actual).to be_kind_of(expected)
    expect(actual).to respond_to(expected)

    # Truthiness and existentialism
    expect(actual).to be_truthy    # passes if actual is truthy (not nil or false)
    expect(actual).to be true      # passes if actual == true
    expect(actual).to be_falsey    # passes if actual is falsy (nil or false)
    expect(actual).to be false     # passes if actual == false
    expect(actual).to be_nil       # passes if actual is nil
    expect(actual).to exist        # passes if actual.exist? and/or actual.exists? are truthy
    expect(actual).to exist(*args) # passes if actual.exist?(*args) and/or actual.exists?(*args) are truthy
  end
end
