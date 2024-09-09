//
//  ContentView.swift
//  YT-DL
//
//  Created by David Guffre on 9/9/24.
//

import SwiftUI


struct ContentView: View {
	@State private var youtubeURL = ""
	@State private var downloadStatus = ""
	
	var body: some View {
		VStack {
			TextField("Enter YouTube URL", text: $youtubeURL)
				.textFieldStyle(RoundedBorderTextFieldStyle())
				.padding()
			
			Button(action: {
				downloadYouTubeVideo(url: youtubeURL)
			}) {
				Text("Download Video")
					.padding()
					.background(Color.blue)
					.foregroundColor(.white)
					.cornerRadius(8)
			}
			.padding()
			
			Text(downloadStatus)
				.padding()
		}
		.frame(width: 400, height: 300)
	}
	
	func downloadYouTubeVideo(url: String) {
		let desktopPath = "/Users/guffmain/Desktop"
		let ytDlpCommand = "/opt/homebrew/bin/yt-dlp" // Ensure this path is correct
		
		// Check if yt-dlp is installed
		guard FileManager.default.fileExists(atPath: ytDlpCommand) else {
			downloadStatus = "yt-dlp is not installed."
			return
		}
		
		// Ensure the URL is correctly escaped for the shell
		let escapedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
		
		// Create the full command to download the video
		let command = "\(ytDlpCommand) \(escapedURL) '\(desktopPath)'"
		
		// Debug: Print the command to ensure it's correct
		print("Running command: \(command)")
		
		// Run the shell command
		runShellCommand(command: command) { output in
			DispatchQueue.main.async {
				if output.isEmpty {
					downloadStatus = "Download complete."
				} else {
					downloadStatus = output
				}
			}
		}
	}
	
	
	func runShellCommand(command: String, completion: @escaping (String) -> Void) {
		let task = Process()
		task.launchPath = "/bin/zsh"
		task.arguments = ["-c", command]
		
		let pipe = Pipe()
		task.standardOutput = pipe
		task.standardError = pipe
		
		let fileHandle = pipe.fileHandleForReading
		task.launch()
		
		task.terminationHandler = { _ in
			let outputData = fileHandle.readDataToEndOfFile()
			let output = String(data: outputData, encoding: .utf8) ?? ""
			print("Command output: \(output)") // Debugging output
			completion(output)
		}
	}
}



#Preview {
    ContentView()
}
