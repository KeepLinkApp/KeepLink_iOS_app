//
//  ContactAddViewModel.swift
//  KeepLink
//
//  Created by Maria Mayorova on 09.02.2025.
//

import SwiftUI
import RealmSwift

final class ContactAddViewModel: ObservableObject {
    @Published var nameTextField: String = ""
    @Published var surnameTextField: String = ""
    @Published var patronymicTextField: String = ""
    @Published var contextTextField: String = ""
    @Published var noteTextField: String = ""
    @Published var phoneTextField: String = ""
    @Published var appearanceTextField: String = ""
    @Published var cityTextField: String = ""
    @Published var streetTextField: String = ""
    @Published var houseTextField: String = ""
    @Published var flatTextField: String = ""
    @Published var websiteTextField: String = ""
    @Published var networkTextField: String = ""
    @Published var professionTextField: String = ""
    @Published var emailTextField: String = ""
    @Published var dateOfBirth = Date()
    
    @Published var selectedImageData: Data? = nil
    
    @Published var selectedTags: [String] = []
    @Published var isShowingContextsOfMeeting = false
    @Published var isShowingTags = false
    
    @Published var isAlertPresented = false // алерт для удаления
    @Published var showPhotosPicker = false
    @Published var showImageCropper = false
    
    func saveContact(_ contact: Contact = Contact()) {
        guard let thawedContact = contact.thaw() else {
            print("Ошибка: Не удалось разморозить объект.")
            return
        }
        
        do {
            let realm = try Realm()
            
            let tags = selectedTags.map { tagString -> Tag in
                let tag = Tag()
                tag.name = tagString
                return tag
            }
            
            let tagsList = RealmSwift.List<Tag>()
            tagsList.append(objectsIn: tags)
            
            let meetingPlace = MeetingPlace()
            meetingPlace.name = contextTextField
            
            let phoneNumbers = RealmSwift.List<PhoneNumber>()
            let number = PhoneNumber()
            number.number = phoneTextField
            number.type = "Основной"
            phoneNumbers.append(number)
            
            let socialNetworks = RealmSwift.List<SocialNetwork>()
            let socialNetwork = SocialNetwork()
            socialNetwork.link = networkTextField
            socialNetwork.type = "Основная"
            socialNetworks.append(socialNetwork)
            
            let professions = RealmSwift.List<Profession>()
            let profession = Profession()
            profession.title = networkTextField
            profession.workplace = "Основная"
            profession.position = "джун"
            professions.append(profession)
            
            let emails = RealmSwift.List<Email>()
            let email = Email()
            email.email = emailTextField
            emails.append(email)
            
            let dates = RealmSwift.List<DateEntry>()
            let date = DateEntry()
            date.date = dateOfBirth
            date.type = "Основная"
            dates.append(date)
            
            try realm.write {
                thawedContact.firstName = nameTextField
                thawedContact.lastName = surnameTextField
                thawedContact.middleName = patronymicTextField
                thawedContact.meetingContext = contextTextField
                thawedContact.appearance = appearanceTextField
                thawedContact.avatarData = selectedImageData
                thawedContact.notes = noteTextField
                thawedContact.tags = tagsList
                thawedContact.meetingPlace = meetingPlace
                thawedContact.phoneNumbers = phoneNumbers
                thawedContact.appearance = appearanceTextField
                thawedContact.city = cityTextField
                thawedContact.street = streetTextField
                thawedContact.house = houseTextField
                thawedContact.apartment = flatTextField
                thawedContact.website = websiteTextField
                thawedContact.socialNetworks = socialNetworks
                thawedContact.professions = professions
                thawedContact.emails = emails
                thawedContact.dates = dates
            }
        } catch {
            print("Ошибка сохранения в Realm: \(error.localizedDescription)")
        }
    }
}
