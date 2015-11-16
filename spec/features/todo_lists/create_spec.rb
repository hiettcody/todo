require 'spec_helper'

describe "Creating todo lists" do
  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:decription] ||= "This is my to do list for the week"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end

  it "redirects to the todo list index page on success" do
    create_todo_list
    expect(page).to have_content("New Todo List")
  end

  it "displays an error when the todo list has no title" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my to do list for the week")
  end

  it "displays an error when the todo list has a title with less than three characters" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Hi"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("This is my to do list for the week")
  end

  it "displays an error when the todo list has no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "Spring Cleaning", description: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Spring Cleaning")
  end

    it "displays an error when the todo list description is less than 7 characters" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: "Spring Cleaning", description: "spring"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Spring Cleaning")
  end
end
