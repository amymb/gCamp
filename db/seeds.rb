# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

common_questions = CommonQuestion.create([
  {question: 'What is gCamp?',
  answer: 'gCamp is an awesome tool that is going to change your life. gCamp is your one stop shop to organize all your tasks. You\'ll also be able to track comments that you and others make. gCamp may eventually replace all need for paper and pens in the entire world. Well, maybe not, but it\'s going to be pretty cool.'
  },
  {question: 'How do I join gCamp?',
    answer: 'As soon as it\'s ready for the public, you\'ll see a signup link in the upper right. Once that\'s there, just click it and fill in the form!'
    },
  {question: 'When will gCamp be finished?',
    answer: 'gCamp is a work in progress. That being said, it should be fully functional in the next few weeks. Functional. Check in daily for new features and awesome functionality. It\'s going to blow your mind. Organization is just a click away. Amazing!'
    }
    ])
