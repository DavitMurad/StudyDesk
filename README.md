# StudyDesk
https://github.com/user-attachments/assets/331f264e-47d1-46d7-aa0c-55d0a2bdf48f

# About 🤌

StudyDesk is a project that blends fun, learning, and a celebration of everyday student life, visualised through 3D models of familiar objects.

As someone deeply interested in AR (which I believe is the next boom in tech), I wanted to build an app that would kick off my journey into AR, a space full of promise and creativity.

So, I thought:
Why not combine my interests, previously learned iOS concepts, and love for SwiftUI all in one solid portfolio piece and creative playground as well as highlight everyday items for us students?

What began as a lighthearted idea turned into a technical deep dive, touching everything from AR interactions and Core Data persistence, to Combine-powered reactivity, simulated networking, and efficient local asset management.

# Technologies Used
**RealityKit** & **ARKit** – for detecting planes and rendering .usdz 3D models into the real world

**SwiftUI** – entire UI built with clean MVVM architecture

**Combine** – to manage timers, publishers/subscribers, and async flows

**Core Data** – to persist user-favorited models

**FileManager** + **Cache** – for locally storing and simulating API asset loading

**QuickLook** (QLPreviewController) – to preview .usdz models natively

**UIKit Integration** – used where SwiftUI needed reinforcement (UIViewRepresentable)

**Haptic Feedback** – because sometimes a small vibration makes a big difference

# Highlights

🔎 AR placement of objects like MacBook, iPhone, AirPods, Notebook, Pen, Coffee, and more

🧠 Desk-aware logic – items only placeable on detected horizontal planes

💙 Favorite system – users can like models and persist their state using Core Data

📦 Offline asset storage – mock API call logic using custom cache + file manager

🧩 Paging DetailView – smooth horizontal swiping across all models

☕️ Interactive Coffee Break – tap the coffee cup to start a break timer using Combine

🧭 Intuitive navigation – tab bar and custom-styled sheets for clarity and focus

🧠 Witty & sarcastic UI – because feedback should have personality

📬 Local push notifications – for reminders and (let’s be honest) more sarcasm

<img width="306" height="51" alt="Screenshot 2025-08-01 at 17 16 36" src="https://github.com/user-attachments/assets/211b606b-aec9-4608-b8b7-1ea3760f910f" />

<img width="310" height="52" alt="Screenshot 2025-08-01 at 17 16 26" src="https://github.com/user-attachments/assets/332e4893-2a66-4149-a88c-0284dd0c613a" />


# Challenges & Learnings


  Build a custom **ARViewContainer** with plane detection and gesture handling

  Safely integrate **UIKit** (like QLPreviewController) into a SwiftUI-first app

  Design with modularity in mind: from fetch logic to **environment object injection**

  Make** Combine timers ** and **publishers** behave predictably within SwiftUI's lifecycle

  Use **Reality Composer Pro** for the first time to manually center and scale .usdz models

  Handle **edge cases** in gesture taps and model placement positioning

  Build a **mock API-like** experience with locally stored 3D assets (cache + fallback)

One fun highlight was designing the “coffee cup timer” : tap the cup, start a Combine-powered countdown, and let the app gently (or sarcastically) remind you to get back to work.

# Reflection

This has been fun. AR was completely new to me and even though I felt confident with Swift and SwiftUI, combining familiar tools in an unfamiliar space e.g Core Data challenged me more than expected.

There were moments where concepts I thought I understood suddenly felt foreign… but that’s how learning works, right? 🧗

I am proud of this app. It is playful, personal, and technically rich a standout piece in my portfolio that reflects both what I know and what I am still eager to explore.

My exploration of Apple’s ecosystem doesn’t end here. In future projects, I plan to dive even deeper into advanced technologies, especially those that push the boundaries of AR and immersive experiences.

Thanks for stopping by.

Forever a student at heart.

Cheers ✌️
