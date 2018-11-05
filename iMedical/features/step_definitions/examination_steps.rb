Given("As a PATIENT") do
    complete_log_in
    expect(current_user.roles_mask).to eq(5)
    visit new_patient_path(current_user.id)
end

When("I click on cerca studio medico button") do
    click_button("Cerca studio medico")
end

Then("I should be redirected to clinics' search form") do
    expect(current_path).to eq("/patient/searchClinic")
end

Given("I am on the clinics search page") do
    visit(search_clinic_path)
end

When("I click on Informazioni button") do
    first('.btn').click
end

Then("I should be redirected to clinic show page") do
    @clinic = Clinic.find(1)
    expect(current_path).to eq(clinics_show_path(1))
end
