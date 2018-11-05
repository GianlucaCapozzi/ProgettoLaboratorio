Given("As a PATIENT") do
    complete_log_in
    expect(current_user.roles_mask).to eq(5)
    visit new_patient_path(current_user.id)
end

When("I click on cerca studio medico button") do
    click_button("Cerca studio medico")
end

Then("I should be redirected to clinics' search form") do
    puts current_path
    expect(current_path).to eq("/patient/searchClinic")
end

Given("I am on the clinics search page") do
    visit(search_clinic_path)
end

When("I click on Informazioni button") do
    page.first(:xpath, "//input[@value='Informazioni']").click
end

Then("I should be redirected to clinic show page") do
    @clinic = Clinic.find(1)
    puts current_path
    expect(current_path).to eq(clinics_show_path(@clinic.id))
end

Given("I am on Info page") do
    @clinic = Clinic.find(1)
    visit(clinics_show_path(@clinic.id))
end

When("I click on lista medici link") do
    click_link("Lista medici")
end

Then("I should be redirected to clinic doctors page") do
    @clinic = Clinic.find(1)
    expect(current_path).to eq(clinic_doctors_path(@clinic.id))
end

Given("I am on clinic doctors page") do
    @clinic = Clinic.find(1)
    visit(clinic_doctors_path(@clinic.id))
end

When("I click on the first doctor link") do
    puts current_path
    page.first(:xpath, "//input[@value='Calendario']").click
end

Then("I should be redirected to clinic doctor page") do
    @clinic = Clinic.find(1)
    @doctor = User.find(2)
    expect(current_path).to eq(clinic_doctor_path(@clinic.id, @doctor.id))
end
