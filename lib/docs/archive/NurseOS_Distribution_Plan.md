
# 📦 NurseOS Distribution Plan (Non-App Store)

## 🎯 Goal
Distribute NurseOS to early nurse testers and concierge users without going through the App Store review process.

---

## 🚀 Options for Internal Distribution

### 1. **TestFlight (Apple Beta Testing)**
- Ideal for up to 10,000 testers
- Requires Apple Developer account ($99/year)
- Upload via Xcode → Distribute → TestFlight
- Share invite link or collect Apple IDs

### 2. **Firebase App Distribution**
- Fastest option if not using TestFlight
- Upload `.ipa` to Firebase → Send download links to testers
- Works with limited group (manual device approval if needed)
- Supports versioning, feedback, and crash reporting

### 3. **Direct Install (.ipa + UDID Whitelisting)**
- Build `.ipa` file from Xcode
- Collect device UDIDs from testers
- Add UDIDs to provisioning profile
- Share install link via Diawi or similar tool

---

## 🔐 Consent + Data Considerations

- Include basic terms of use during onboarding
- Clearly state app is for testing only, not for patient charting yet
- Avoid storing PHI or transmitting live data during MVP phase

---

## 📱 Device Support (Phase 1)
- iOS only
- Built and tested for iPhone (Simulator + physical devices)
- No Android or Web deployment until Phase 8+

---

## 📝 Internal Testing Tips
- Test all flows offline
- Use mock data to simulate full patient lifecycle
- Collect feedback via embedded prompt or post-shift survey

---

*Launch quietly. Learn fast. Earn trust from the very first shift.*
