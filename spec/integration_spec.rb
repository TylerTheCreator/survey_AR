require("spec_helper")
require("./app")

Capybara.app = Sinatra::Application

describe("/surveys", {:type => :feature}) do
  it("will allow user to add a survey and will display all surveys") do
    visit("/surveys")
    fill_in("name", :with => "Favorite Color Survey")
    click_button("Submit!")
    expect(page).to have_content("Favorite Color Survey")
  end
end

describe('/surveys/:id', {type: :feature}) do
  it('will allow user to update a survey name') do
    test_survey = Survey.new({name: 'kasdnl'})
    test_survey.save()
    visit("/surveys/#{test_survey.id}")
    fill_in("name", with: "red survey")
    click_button("Update!")
    expect(page).to have_content("Red Survey")
  end

  it("will allow the user to delete a survey") do
    test_survey = Survey.new({name: 'Red Survey'})
    test_survey.save()
    visit("/surveys/#{test_survey.id()}")
    click_button("Delete")
    expect(page).to have_no_content("Red Survey")
  end

  it("will allow the user to add a question to a survey") do
    test_survey = Survey.new({name: 'Red Survey'})
    test_survey.save()
    test_question = Question.new({description: 'hha'})
    test_question.save()
    visit("/surveys/#{test_survey.id}")
    fill_in('description', with: "hha")
    click_button("Submit!")
    expect(page).to have_content("Hha")
  end
end


describe("/questions/:id", {type: :feature}) do
  it("will allow the user to edit a question") do
    test_survey = Survey.new({name: 'Red Survey'})
    test_survey.save()
    test_question = Question.new({description: 'hha', survey_id: test_survey.id()})
    test_question.save()
    visit("/questions/#{test_question.id}")
    fill_in("description", with: "why?")
    click_button("Update!")
    expect(page).to have_content("Why?")
  end

  it("will allow the user to delete a question") do
    test_survey = Survey.new({name: 'Red Survey'})
    test_survey.save()
    test_question = Question.new({description: 'hha', survey_id: test_survey.id()})
    test_question.save()
    visit("/questions/#{test_question.id}")
    click_button("Delete")
    expect(page).to have_no_content("Hha")
  end
end
