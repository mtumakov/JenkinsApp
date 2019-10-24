//
//  JenkinsModels.swift
//  JenkinsRefactoredApp
//
//  Created by Mihail Tumakov on 14/10/2019.
//  Copyright © 2019 Mihail Tumakov. All rights reserved.
//

import Foundation

struct MainPage: Decodable {
    let nodeDescription: String
    let numExecutors: Int
    let jobs: [Job]
    let primaryView: Job
    let views: [Job]
}

struct Folder: Decodable {
    let _class: String
    let description: String
    let displayName: String
    let displayNameOrNull: String?
    let fullDisplayName: String
    let name: String
    let url: String
    let jobs: [Job]
    let primaryView: Job
    let views: [Job]
}

struct DetailedJob: Decodable {
    let _class: String
    let actions: [Action]
    let description: String
    let displayName: String
    let displayNameOrNull: String?
    let fullDisplayName: String
    let name: String
    let url: String
    let buildable: Bool
    let builds: [Build]
    //    let firstBuild: Build
    //    let lastBuild: Build
}

struct Build: Decodable {
    let _class: String
    let number: Int
    let url: String
}

struct Action: Decodable {
    //    let _class: String
    //    let parameterDefinitions: [Parameter]
}

struct Parameter: Decodable {
    //    let _class: String
    //    let defaultParameterValue: Int
    //    let description: String
    //    let name: String
    //    let type: String
}

struct Job: Decodable {
    let _class: String
    let name: String
    let url: String
    let color: String?
}
