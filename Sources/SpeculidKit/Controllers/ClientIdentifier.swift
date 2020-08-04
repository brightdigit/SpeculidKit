//
//  ClientIdentifier.swift
//  speculid
//
//  Created by Leo Dion on 10/18/16.
//
//
import Foundation

public struct ClientIdentifier: ClientIdentifiable {
  public static let shared = ClientIdentifier()
  public let clientIdentifier: UUID

  public static func calculateIdentifier() -> UUID {
    guard let clientIdentifier = UserDefaults.standard.string(forKey: "clientIdentifier").flatMap(UUID.init(uuidString:)) else {
      let uuid = UUID()
      UserDefaults.standard.set(uuid.uuidString, forKey: "clientIdentifier")
      return uuid
    }

    return clientIdentifier
  }

  public init() {
    clientIdentifier = ClientIdentifier.calculateIdentifier()
  }
}
