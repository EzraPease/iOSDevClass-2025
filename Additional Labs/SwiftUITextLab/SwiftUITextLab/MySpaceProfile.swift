//
//  MySpaceProfile.swift
//  SwiftUITextLab
//
//  Created by Jane Madsen on 9/10/25.
//

import SwiftUI

/*
 ## Instructions:
 Your goal is to create an app that will serve as a social media profile. Use Text view modifiers to arrange and style your profile to reflect your unique style.
 
 Since this assignment will require you to choose custom fonts, you may want to open the Font Book app installed on your Mac, where you can view a list of the fonts available on Mac and iOS by default.
 
 If you would like to change the background color of each of these views, you can do so by changing the colors listed in each #Preview macro at the bottom of the page.
 
 1. Create three structs that conform to View: ProfileView, TopFiveFriendsView, and BlogPostView. This will fix the errors
 2. To see a preview of how each view will look in the app, make sure you have opened your canvas (Option + Command + Return). You can view each struct you've created by clicking on the tabs at the top of the canvas.
 3. Create a profile view with Text elements for each of the following items: Username, Real Name, Home City, and Bio. Style each of them appropriately with custom fonts, font sizes, and colors for each. Feel free to add any additional modifiers as well.
 4. Create a TopFiveFriends view with a list of your friends, ranked in order of favorite to least favorite. (Don't worry, we won't tell them). Use a different font and color for each person, and include an Emoji to represent each one as well.
 5. Create a BlogPostView. Write a long blog post. Give your blog post a title, a date posted, a body, and a display of number of likes and comments. Once again, style each individually with fonts, font sizes, and colors, and any other modifiers you would like.
 6. Try running the app. You should see all three views embedded in Tabs (the code for this is in SwiftUITextLabApp.swift). You may need to adjust the style slightly to accommodate the Tab Bar at the bottom of the screen.
 
 ## Black Diamond
 
 7. Add one or more Image views to each page.
 8. Use Stack views to arrange your content more dynamically.
 
 ## Rubric
 
 - App has a profile view with Username, Real Name, Home City, and Bio, appropriately filled out and styled.
 - App has a Top Five Friends screen with emoji, fonts, and colors for each friend.
 - App has a blog post view with a title, a date posted, a body, and a number of likes and comments. All are styled, sized, and colored appropriately.
 */

#Preview("ProfileView") {
    ProfileView()
        .background(.white)
}

#Preview("TopFiveFriendsView") {
    TopFiveFriendsView()
        .background(.white)
}

#Preview("BlogPostView") {
    BlogPostView()
        .background(.white)
}

struct ProfileView: View {
    var body: some View {
        Text ("MikeIGL")
            .foregroundStyle(.white)
            .font(.custom("AcademyEngravedLetPlain", size: 40))
            .underline()
            .padding(100)
            .background(
                LinearGradient(
                    colors: [.mint, .yellow],
                    startPoint: .center,
                    endPoint: .topTrailing
                ),
                in: Capsule()
            )
            .position(x: 200, y: 200)
        Text ("I never know what I should put here")
            .foregroundStyle(.white)
            .font(.custom("ArialRoundedMTBold", size: 15))
            .position(x: 200, y: -120)
        Text ("Ezra Pease")
            .italic()
            .font(.title3)
        Text ("Orem")
            .italic()
            .font(.title3)
        Text("iOS Develelopment")
            .font(.custom("SnellRoundhand", size: 22))
    }
}

struct TopFiveFriendsView: View {
    var body: some View {
        Text ("❤️ - Alison")
            .foregroundStyle(.red)
            .font(.custom("Zapfino", size: 20))
        Text ("🏭 - Mathew")
            .foregroundStyle(.green)
            .font(.custom("Papyrus", size: 20))
        Text ("🎶 - James")
            .foregroundStyle(.blue)
            .font(.custom("Herculanum", size: 20))
        Text ("🔫 - Dani")
            .foregroundStyle(.yellow)
            .font(.custom("American Typewriter", size: 20))
        Text ("💂 - AJ")
            .foregroundStyle(.black)
            .font(.footnote)
    }
}

struct BlogPostView: View {
    var title: some View {
        Text ("Ezra's Daily Blog")
            .font(.largeTitle)
            .bold()
    }
    var date: some View {
        Text ("9/24/2025")
            .foregroundStyle(.secondary)
    }
    var likesAndComments: some View {
        Text ("❤️: 573       💬: 322")
            .foregroundStyle(.secondary)
            .font(.title3)
            .italic()
            .bold()
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                title
                date
                likesAndComments
                Text ("""
The name Ezra has always felt like more than just a name to me—it carries a story. Its Hebrew roots mean “help” or “helper,” and that meaning has always resonated deeply. In the Bible, Ezra was a scribe and leader who guided his people back home, a figure tied to wisdom, courage, and rebuilding. I like to think that, in some way, the name I carry connects me to those same qualities of resilience, guidance, and purpose. It reminds me that even small acts of helping can ripple outward and make a difference, just as Ezra’s leadership did in ancient times.

Over the years, I’ve noticed how Ezra shows up in different places—whether in literature through Ezra Pound, in music, or in modern culture. Each time I hear it, there’s a spark of recognition, like the name is carrying its history forward while still finding new expressions. It has this unusual balance: short, strong, and simple, but also layered with meaning. That balance between tradition and creativity feels like something I try to carry into my own life—finding ways to stay grounded while also exploring new paths.

The rise in popularity of the name Ezra has been fascinating to watch. More and more parents are choosing it for their children, and I completely understand why. It’s timeless yet modern, familiar yet unique, and it has a warmth that makes it approachable. For me, though, it’s never just been about the trendiness of the name. It’s part of my identity, something that feels deeply personal. It’s a reminder that names can connect us to something larger—history, faith, or simply a sense of belonging—while also being a reflection of who we choose to be.

When I think about the name Ezra, I see it as a bridge between the past and the present. It carries the weight of ancient stories but also adapts beautifully to the modern world. It’s a name that fits in conversations about spirituality, art, music, and even everyday life. For me, that makes it more than just four letters strung together—it’s a piece of my story, a touchstone that keeps me mindful of strength, wisdom, and individuality. In many ways, living up to the name Ezra feels like an ongoing journey, one that continues to shape who I am and who I hope to become.
"""

                )
            }
        }
    }
}

