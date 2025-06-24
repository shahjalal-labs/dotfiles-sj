api.mapkey("<ctrl-y>", "Show me the money", function () {
  Front.showPopup(
    "a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).",
  );
});

//t: an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
api.map("gt", "t");
api.map("w", "d");
api.map("t", "T");
api.map("ao", ";di");
api.map("su", ";U");
api.map("C-1", "g0");
// api.map("ss", "on");
api.map("aa", "S");
api.map("<Alt-j>", "l");
api.map("<Alt-k>", "h");
api.map("h", "E");
api.map("gj", "G");
api.map("gi", "yy", /.*youtube.*/i);
//api.map("t", "f");
//api.map("f", "t");
api.map("l", "R");
api.lmap("f", "<t>");
api.map("as", ";fs");
api.map("u", "<Ctrl-i>");
api.map("Ctrl+d", "<Ctrl-f>");
// api.map("<Ctrl-i>", "<Alt-s>"); // hotkey must be one keystroke with/without modifier, it can not be a sequence of keystrokes like `gg`.
// an example to remove mapkey `Ctrl-i`
api.unmap("<ctrl-i>");
api.map(",", "<Ctrl-6>");
// Add your custom mapping here

api.Hints.setCharacters("asdjkluiopwerm,nhgzxcvq'["); // for right hand  hints will show for now right hands

settings.startToShowEmoji = 1;
//
//
//
//
//
//
//
//
//
//
//
//
//w: opening daisy ui
api.mapkey("cd", "daisy ui", function () {
  if (window.location.hostname.includes("daisy")) {
    window.location.href = "https://daisyui.com/docs/install/vite/";
  } else {
    window.open("https://daisyui.com/docs/install/vite/", "_blank");
  }
});

//t:  opening function
//
//t: facebook
api.mapkey(
  "sf",
  "Open Facebook",
  function () {
    window.open("https://www.facebook.com", "_blank");
  },
  {
    domain: /./, // Apply this mapping to all domains
  },
);
//w: opening perplexity ai ai

api.mapkey("ax", "perplexity ai", function () {
  if (window.location.hostname.includes("perplexity")) {
    window.location.href = "https://www.perplexity.ai/";
  } else {
    window.open("https://www.perplexity.ai/", "_blank");
  }
});

//w: opening gemini ai

api.mapkey("gh", "gemini ai", function () {
  if (window.location.hostname.includes("gemini")) {
    window.location.href = "https://gemini.google.com/app";
  } else {
    window.open("https://gemini.google.com/app", "_blank");
  }
});

//t: discord opening
api.mapkey("so", "scribble l1b10", () => {
  window.open(
    "https://web.programming-hero.com/update-1/video/update-1-42-1-scribbles-cafe-project-overview-and-tailwind-setup",
    "_blank",
  );
});
//
//
//
//
//t:  open deep  ai
api.mapkey("ah", "Deep ai", function () {
  window.open("https://deepai.org/dashboard/images", "_blank");
});
//
//
//
//t: opening dotfiles
api.mapkey("ad", "Dotfiles", function () {
  window.open(
    "https://github.com/mdshahjalal5/allDotfilesBackupEndeavourOs",
    "_blank",
  );
});

//
//
//
//
//
api.mapkey("a,", "HELP DESK", function () {
  window.open("https://helpdesk.programming-hero.com/", "_blank");
});
//
//
//
//
//
api.mapkey("ay", "youtube opening", function () {
  window.open("https://www.youtube.com/", "_blank");
});
//
//
//
//
api.mapkey("at", "tailwind css v4 installation", function () {
  window.open("https://tailwindcss.com/docs/installation/using-vite", "_blank");
});
//
//
//
//
//
//
//
//
//t: Open Quran
//
api.mapkey("sq", "Open Quran", function () {
  window.open("https://quran.com", "_blank");
}); //
//
//
//
//
//
//
//
//
//
//
//
//t:https://web.programming-hero.com/level2-batch-4/video/level2-batch-4-1-12-never-unknown-and-nullable-type
api.mapkey("sa", "email inbox opening", function () {
  window.open("https://mail.google.com/mail/u/0/?tab=rm&ogbl#inbox", "_blank");
});
api.mapkey("sn", "PH b11 github repositories", function () {
  window.open("https://github.com/ProgrammingHero1?tab=repositories", "_blank");
});
//t: fbLevel1
api.mapkey("s1", "fbLevel1", function () {
  window.open("https://www.facebook.com/groups/programmingHero", "_blank");
});
//t:L2B4Web
api.mapkey("si", "L2B4Web", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-4-frontend-track/video/level2-batch-4-frontend-track-36-11-displaying-blogs-and-handling-loading-with-rtk-query-module-summary",
    "_blank",
  );
});
//t: outline L2B4 https://web.programming-hero.com/web-11/video/web-11-0-1-welcome-message
api.mapkey("sk", "outline L2B4", function () {
  window.open(
    "https://web.programming-hero.com/676fa61320dff5186afcd780/course-outline",
    "_blank",
  );
});
//
//
//p: coceptual level1 batch 9
api.mapkey("ae", "Conceptual Level1 Batch 9", function () {
  window.open("https://web.programming-hero.com/conceptual-session", "_blank");
});
//
//
//
//
//p: coceptual level1 batch 11
api.mapkey("ac", "Conceptual Level1 Batch 11", function () {
  window.open("https://web.programming-hero.com/conceptual-session", "_blank");
});
////
//
//
//
//
//p: level1 batch 11
api.mapkey("ai", "Level1 Batch 11", function () {
  window.open(
    "https://web.programming-hero.com/web-11/video/web-11-15-9-module-summary-legal-system-practice-task-",
    "_blank",
  );
});
//
//
//
//
//
//
//p: outline level1 batch 11
api.mapkey("ak", "outline level1 batch 11", function () {
  window.open(
    "https://web.programming-hero.com/675439d776a088463223e16d/course-outline",
    "_blank",
  );
});
//
//
//
//
//p: level1 batch 11 fb suport group
api.mapkey("aj", "fb  Level1 Batch 11 support group", function () {
  window.open("https://www.facebook.com/groups/targetwebdevcareer", "_blank");
});
//
//
//
//
//
//
//t: fbLevel2
api.mapkey("s2", "fbLevel2", function () {
  window.open("https://www.facebook.com/groups/phapollo4", "_blank");
});
//t:L2B4
api.mapkey("s4", "L2B4 typescript module 2", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-4/video/level2-batch-4-2-1-type-assertion-type-narrowing",
  );
});
//t: pre requisite
api.mapkey("sp", "pre requisite level2", function () {
  window.open(
    "https://web.programming-hero.com/next-level-prerequisites-batch4/video/next-level-prerequisites-batch4-45-8-active-route-loading-spinner-uselocation-usenavigation",
    "_blank",
  );
});
//t:redux
api.mapkey("sr", "redux", function () {
  window.open(
    "https://web.programming-hero.com/level2-batch-1/video/level2-batch-1-21-1-project-initialization-and-redux-store-setup-recap",
    "_blank",
  );
});
//t: open  chatgpt
/* api.mapkey("sc", "Open chatgpt", function () {
  window.open("https://chatgpt.com/", "_blank");
  let p = document.querySelector("#prompt-textarea  p");
  console.log(`p tag `, p);
}); */
api.mapkey("sc", "Open ChatGPT chk", function () {
  let newTab = window.open("https://chatgpt.com/", "_blank"); // Open ChatGPT in a new tab
  console.log(newTab, ".surfingkeys.js", 240);
  setInterval(() => {
    console.log(`hellow`);
  }, 2000);
});

//
//
//
//
//
//
//t: open  claude ai
api.mapkey("al", "Open claude ai", function () {
  window.open("https://claude.ai/new");
});
api.mapkey("am", "Chk claude", function () {
  if (window.location.hostname.includes("claude.ai")) {
    window.location.href = "/new";
  } else {
    window.open("https://claude.ai/new", "_blank");
  }
});

//t: github repository page opening
api.mapkey("gr", "Repository Github", function () {
  window.open("https://github.com/mdshahjalal-labs?tab=repositories", "_blank");
});

//t:  new repo for github

api.mapkey("gn", "new repo github", function () {
  window.open("https://github.com/new", "_blank");
});
//t:Open blank page
api.mapkey("sb", "Open blank page", function () {
  window.open("https://blank.page/", "_blank");
});
//t:localhost
api.mapkey("sl", "localhost", function () {
  window.open("http://localhost:5173/", "_blank");
});

//t: open whatsApp
api.mapkey("sm", "whatsApp", function () {
  window.open("https://web.whatsapp.com/", "_blank");
});

//
//
//
//
//
//
//
//
//
//
//t: Nasheed and tilawat
//
//
//t: Open Wedding Nasheed
api.mapkey("sj", "Open Wedding Nasheed", function () {
  window.open(
    "https://www.youtube.com/watch?v=dWBgNHT4ipE&ab_channel=HuzaifahNasheeds",
    "_blank",
  );
});
//
//
//t: isami music playlist
//
//
//
/* api.mapkey("su", "isami music playlist", function () {
  window.open(
    "https://www.youtube.com/watch?v=rL6qQ49hBlQ&list=PLXOE5SEv6NpDUSPNxCu1fFTfBi8HZDeJM",
    "_blank",
  );
}); */
//t: Open 5 Nasheed
api.mapkey("ci", "🖼️ Copy image URL under cursor or focused image", () => {
  const img = document.querySelector("img:hover") || document.activeElement;
  if (img && img.tagName === "IMG") {
    const url = img.src;
    if (url) {
      api.Clipboard.write(url);
    }
  }
});

let copyLoopActive = false;

api.mapkey(
  "cl",
  "🔁 Copy multiple image URLs with hints loop",
  function startCopyLoop() {
    copyLoopActive = true;

    const copyImageWithHints = () => {
      if (!copyLoopActive) return;

      api.Hints.create("img[src]", function (el) {
        api.Clipboard.write(el.src);

        // Delay a bit and show hints again
        setTimeout(copyImageWithHints, 300);
      });
    };

    copyImageWithHints();
  },
);

api.mapkey("<Esc>", "❌ Stop image copy loop", function () {
  copyLoopActive = false;
  api.Front.showBanner("🛑 Copy loop stopped");
});

api.mapkey("cj", "📷 Copy image URL using hints", function () {
  api.Hints.create("img[src]", function (el) {
    api.Clipboard.write(el.src);
  });
});

//
//
// 🔁 Persistent smart click loop that detects and clicks both semantic and styled custom clickable elements across page navigations.

api.mapkey("cb", "🔁 Persistent click hints", function repeatClickHints() {
  api.Hints.create("*[onclick], button, a, input[type=submit]", function (el) {
    el.click();

    // Wait a short moment, then re-show hints
    setTimeout(() => {
      repeatClickHints(); // Call itself again
    }, 200); // Delay to allow DOM to update
  });
});

api.mapkey("cm", "📄 Copy image as Markdown", function () {
  api.Hints.create("img[src]", function (el) {
    const alt = el.alt || "image";
    const markdown = `![${alt}](${el.src})`;
    api.Clipboard.write(markdown);
    api.Front.showPopup("✅ Copied as Markdown!");
  });
});

api.mapkey("ch", "🖱️ Smart hover using hints", function () {
  api.Hints.create("*", function (el) {
    ["mouseover", "mouseenter", "focus"].forEach((type) => {
      el.dispatchEvent(
        new MouseEvent(type, { bubbles: true, cancelable: true, view: window }),
      );
    });

    // api.Front.showPopup("🟡 Hovered or focused: " + (el.alt || el.innerText || el.tagName));
  });
});

api.mapkey("cu", "🖱️ Move mouse cursor to element using hints", function () {
  api.Hints.create("*", function (el) {
    const rect = el.getBoundingClientRect();
    const x = rect.left + rect.width / 2;
    const y = rect.top + rect.height / 2;

    // Move actual mouse pointer using RUNTIME
    api.RUNTIME("moveTabSelection", {
      x: Math.round(x),
      y: Math.round(y),
    });

    // api.Front.showPopup("🎯 Moved to: " + (el.alt || el.innerText || el.tagName));
  });
});

api.mapkey("ck", "🌒 Toggle dark mode (CSS inversion)", function () {
  if (!document.getElementById("__sk_darkmode")) {
    const style = document.createElement("style");
    style.id = "__sk_darkmode";
    style.innerHTML = `html { filter: invert(0.92) hue-rotate(180deg); background: #111 !important; } img, video { filter: invert(1) hue-rotate(180deg) !important; }`;
    document.head.appendChild(style);
    api.Front.showBanner("🌚 Dark mode ON");
  } else {
    document.getElementById("__sk_darkmode").remove();
    api.Front.showBanner("🌞 Dark mode OFF");
  }
});

api.mapkey("ca", "🔍 Reveal hidden elements using hints", function () {
  api.Hints.create("*", function (el) {
    el.style.display = "block";
    el.style.visibility = "visible";
    el.style.opacity = "1";
    el.hidden = false;
    api.Front.showPopup("✅ Revealed element: " + el.tagName);
  });
});

api.vmapkey("ck", "🧠 Summarize selected text using ChatGPT", function () {
  window.getSelection().toString().length > 0
    ? api.Clipboard.write(window.getSelection().toString())
    : api.Front.showPopup("❗ Select some text first");

  setTimeout(() => {
    const query = encodeURIComponent(
      "summarize: " + window.getSelection().toString(),
    );
    window.open("https://chat.openai.com/chat?q=" + query, "_blank");
  }, 300);
});

//
//
//
//
//
//
//
//
//
//t:  set theme
// settings.theme = `
// .sk_theme {
//     font-family: Input Sans Condensed, Charcoal, sans-serif;
//     font-size: 10pt;
//     background: #24272e;
//     color: #abb2bf;
// }
// .sk_theme tbody {
//     color: #fff;
// }
// .sk_theme input {
//     color: #d0d0d0;
// }
// .sk_theme .url {
//     color: #61afef;
// }
// .sk_theme .annotation {
//     color: #56b6c2;
// }
// .sk_theme .omnibar_highlight {
//     color: #528bff;
// }
// .sk_theme .omnibar_timestamp {
//     color: #e5c07b;
// }
// .sk_theme .omnibar_visitcount {
//     color: #98c379;
// }
// .sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
//     background: #303030;
// }
// .sk_theme #sk_omnibarSearchResult ul li.focused {
//     background: #3e4452;
// }
// #sk_status, #sk_find {
//     font-size: 20pt;
// }`;
//
//
//
//
//
//w: 25/11/2024 12:51 PM Mon GMT+6 Sharifpur, Gazipur, Dhaka
settings.theme = `
.sk_theme {
    font-family: "Input Sans Condensed", Charcoal, sans-serif;
    font-size: 10pt;
    background: #1e1e2e; /* Base */
    color: #cdd6f4; /* Text */
}
.sk_theme tbody {
    color: #f5e0dc; /* Light text */
}
.sk_theme input {
    color: #cdd6f4; /* Input text */
}
.sk_theme .url {
    color: #89b4aa; /* Blue */
}
.sk_theme .annotation {
    color: #f5c2e7; /* Pink */
}
.sk_theme .omnibar_highlight {
    color: #a6e3a1; /* Green */
}
.sk_theme .omnibar_timestamp {
    color: #fab387; /* Peach */
}
.sk_theme .omnibar_visitcount {
    color: #f9e2af; /* Yellow */
}
.sk_theme #sk_omnibarSearchResult ul li:nth-child(odd) {
    background: #181825; /* Darker Base */
}
.sk_theme #sk_omnibarSearchResult ul li.focused {
    background: #313244; /* Highlight */
}
#sk_status, #sk_find {
    font-size: 20pt;
    background: #1e1e2e; /* Base */
    color: #cdd6f4; /* Text */
}`;
