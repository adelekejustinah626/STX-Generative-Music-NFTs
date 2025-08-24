
STX-Generative-Music-NFTs 🎶

Version: 1.0.0

Summary: Generative Music NFTs – Each NFT plays a unique on-chain generated tune

📖 Overview

STX-Generative-Music-NFTs is a smart contract built with Clarity on the Stacks blockchain.
It enables the creation of generative NFTs, where each token represents a unique, on-chain musical composition generated at the time of minting.

Each NFT contains:

A melody made up of 16 notes generated pseudo-randomly.

Notes chosen from 12 chromatic pitches and restricted to the major scale.

Randomized octaves and durations for variety.

Metadata including a name and description.

This makes every NFT provably unique, fully on-chain, and collectible.

⚙️ Features

✅ On-chain melody generation (unique sequence of notes, octaves, and durations).

✅ Minting function with customizable mint price.

✅ Secure ownership transfer through SIP-009 compliant NFT functionality.

✅ Token metadata storage for human-readable details.

✅ Public read-only queries for melodies, metadata, and ownership.

✅ Optional metadata URI to integrate with external APIs for richer metadata and playback.

🛠️ Contract Functions
🔑 Public Functions

(mint-music-nft)

Mints a new Generative Music NFT.

Transfers mint fee to the contract owner.

Generates and stores melody + metadata.

Returns the token ID.

(transfer token-id sender recipient)

Transfers ownership of a token.

(set-mint-price new-price)

Updates the minting price.

Restricted to contract owner.

👀 Read-Only Functions

(get-last-token-id) → Last minted token ID.

(get-mint-price) → Current mint price.

(get-owner token-id) → NFT owner.

(get-token-music token-id) → Generated melody data (list of notes, octaves, durations).

(get-token-metadata token-id) → NFT metadata (name + description).

(get-token-uri token-id) → API endpoint for external metadata.

🎼 Melody Generation

Each melody consists of 16 pseudo-randomly generated notes, determined by:

Note: Selected from the major scale (C, D, E, F, G, A, B with sharps).

Octave: Randomized from 3 – 6.

Duration: Chosen from whole, half, quarter, or eighth notes.

This ensures every minted NFT produces a unique and reproducible tune.

💰 Minting Details

Default mint price: 1 STX.

Paid directly to contract owner.

Adjustable by the contract owner via (set-mint-price).

🔒 Error Handling

ERR_OWNER_ONLY (u100) → Only contract owner can call certain functions.

ERR_NOT_TOKEN_OWNER (u101) → Unauthorized transfer attempt.

ERR_TOKEN_NOT_FOUND (u102) → Non-existent token.

ERR_MINT_FAILED (u103) → Insufficient funds or failed minting.

🚀 Future Improvements

Integration with MIDI/audio rendering to hear compositions directly.

Expanded scales and modes (minor, pentatonic, etc.).

On-chain visualization of notes.

Support for royalties and secondary sales.

📌 Example Flow

User calls (mint-music-nft) → Pays 1 STX.

Contract generates new melody + metadata.

NFT minted → User becomes owner.

Anyone can view melody/metadata using read-only functions.

📜 License

MIT License – Free to use, modify, and extend.