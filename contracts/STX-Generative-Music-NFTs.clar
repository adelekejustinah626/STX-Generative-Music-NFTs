;; title: STX-Generative-Music-NFTs
;; version: 1.0.0
;; summary: Generative Music NFTs - Each NFT plays a unique on-chain generated tune
;; description: A smart contract that generates unique musical patterns on-chain for NFTs

;; token definitions
(define-non-fungible-token generative-music-nft uint)

;; constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_OWNER_ONLY (err u100))
(define-constant ERR_NOT_TOKEN_OWNER (err u101))
(define-constant ERR_TOKEN_NOT_FOUND (err u102))
(define-constant ERR_MINT_FAILED (err u103))

;; Musical constants
(define-constant NOTES (list "C" "C#" "D" "D#" "E" "F" "F#" "G" "G#" "A" "A#" "B"))
(define-constant OCTAVES (list u3 u4 u5 u6))
(define-constant DURATIONS (list u1 u2 u4 u8)) ;; quarter, half, whole, eighth notes
(define-constant SCALES (list u0 u2 u4 u5 u7 u9 u11)) ;; Major scale intervals

;; data vars
(define-data-var last-token-id uint u0)
(define-data-var mint-price uint u1000000) ;; 1 STX

;; data maps
(define-map token-music uint (list 16 {note: (string-ascii 3), octave: uint, duration: uint}))
(define-map token-metadata uint {name: (string-ascii 50), description: (string-ascii 200)})

;; private functions
(define-private (get-pseudo-random (seed uint) (max uint))
  (mod (+ (* seed u16807) u12345) max)
)

(define-private (generate-note (token-id uint) (position uint))
  (let (
    (seed (+ (* token-id u1000) position))
    (note-index (get-pseudo-random seed u12))
    (octave-index (get-pseudo-random (+ seed u1) u4))
    (duration-index (get-pseudo-random (+ seed u2) u4))
    (scale-index (get-pseudo-random (+ seed u3) u7))
  )
  {
    note: (unwrap-panic (element-at NOTES (unwrap-panic (element-at SCALES scale-index)))),
    octave: (unwrap-panic (element-at OCTAVES octave-index)),
    duration: (unwrap-panic (element-at DURATIONS duration-index))
  })
)

(define-private (generate-melody (token-id uint))
  (list
    (generate-note token-id u0)
    (generate-note token-id u1)
    (generate-note token-id u2)
    (generate-note token-id u3)
    (generate-note token-id u4)
    (generate-note token-id u5)
    (generate-note token-id u6)
    (generate-note token-id u7)
    (generate-note token-id u8)
    (generate-note token-id u9)
    (generate-note token-id u10)
    (generate-note token-id u11)
    (generate-note token-id u12)
    (generate-note token-id u13)
    (generate-note token-id u14)
    (generate-note token-id u15)
  )
)

;; public functions
(define-public (mint-music-nft)
  (let (
    (token-id (+ (var-get last-token-id) u1))
    (melody (generate-melody token-id))
  )
  (asserts! (>= (stx-get-balance tx-sender) (var-get mint-price)) ERR_MINT_FAILED)
  (try! (stx-transfer? (var-get mint-price) tx-sender CONTRACT_OWNER))
  (try! (nft-mint? generative-music-nft token-id tx-sender))
  (map-set token-music token-id melody)
  (map-set token-metadata token-id {
    name: "Generative Music NFT",
    description: "A unique on-chain generated musical composition"
  })
  (var-set last-token-id token-id)
  (ok token-id))
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)
    (nft-transfer? generative-music-nft token-id sender recipient))
)

(define-public (set-mint-price (new-price uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) ERR_OWNER_ONLY)
    (ok (var-set mint-price new-price)))
)

;; read only functions
(define-read-only (get-last-token-id)
  (ok (var-get last-token-id))
)

(define-read-only (get-mint-price)
  (ok (var-get mint-price))
)

(define-read-only (get-owner (token-id uint))
  (ok (nft-get-owner? generative-music-nft token-id))
)

(define-read-only (get-token-music (token-id uint))
  (map-get? token-music token-id)
)

(define-read-only (get-token-metadata (token-id uint))
  (map-get? token-metadata token-id)
)

(define-read-only (get-token-uri (token-id uint))
  (ok (some (concat "https://api.generative-music-nfts.com/metadata/" (int-to-ascii token-id))))
)