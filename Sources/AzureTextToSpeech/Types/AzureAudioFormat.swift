//
//  File.swift
//
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation

public enum AzureAudioFormat: String, CaseIterable, Identifiable {
    case amrWB16000Hz = "amr-wb-16000hz"
    case audio16kHz16bit32kbpsMonoOpus = "audio-16khz-16bit-32kbps-mono-opus"
    case audio16kHz32kbitrateMonoMP3 = "audio-16khz-32kbitrate-mono-mp3"
    case audio16kHz64kbitrateMonoMP3 = "audio-16khz-64kbitrate-mono-mp3"
    case audio16kHz128kbitrateMonoMP3 = "audio-16khz-128kbitrate-mono-mp3"
    case audio24kHz16bit24kbpsMonoOpus = "audio-24khz-16bit-24kbps-mono-opus"
    case audio24kHz16bit48kbpsMonoOpus = "audio-24khz-16bit-48kbps-mono-opus"
    case audio24kHz48kbitrateMonoMP3 = "audio-24khz-48kbitrate-mono-mp3"
    case audio24kHz96kbitrateMonoMP3 = "audio-24khz-96kbitrate-mono-mp3"
    case audio24kHz160kbitrateMonoMP3 = "audio-24khz-160kbitrate-mono-mp3"
    case audio48kHz96kbitrateMonoMP3 = "audio-48khz-96kbitrate-mono-mp3"
    case audio48kHz192kbitrateMonoMP3 = "audio-48khz-192kbitrate-mono-mp3"
    case ogg16kHz16bitMonoOpus = "ogg-16khz-16bit-mono-opus"
    case ogg24kHz16bitMonoOpus = "ogg-24khz-16bit-mono-opus"
    case ogg48kHz16bitMonoOpus = "ogg-48khz-16bit-mono-opus"
    case raw8kHz8bitMonoALaw = "raw-8khz-8bit-mono-alaw"
    case raw8kHz8bitMonoMuLaw = "raw-8khz-8bit-mono-mulaw"
    case raw8kHz16bitMonoPCM = "raw-8khz-16bit-mono-pcm"
    case raw16kHz16bitMonoPCM = "raw-16khz-16bit-mono-pcm"
    case raw16kHz16bitMonoTrueSilk = "raw-16khz-16bit-mono-truesilk"
    case raw22050Hz16bitMonoPCM = "raw-22050hz-16bit-mono-pcm"
    case raw24kHz16bitMonoPCM = "raw-24khz-16bit-mono-pcm"
    case raw24kHz16bitMonoTrueSilk = "raw-24khz-16bit-mono-truesilk"
    case raw44100Hz16bitMonoPCM = "raw-44100hz-16bit-mono-pcm"
    case raw48kHz16bitMonoPCM = "raw-48khz-16bit-mono-pcm"
    case webm16kHz16bitMonoOpus = "webm-16khz-16bit-mono-opus"
    case webm24kHz16bit24kbpsMonoOpus = "webm-24khz-16bit-24kbps-mono-opus"
    case webm24kHz16bitMonoOpus = "webm-24khz-16bit-mono-opus"

    case riff8kHz8bitMonoALaw = "riff-8khz-8bit-mono-alaw"
    case riff8kHz8bitMonoMuLaw = "riff-8khz-8bit-mono-mulaw"
    case riff8kHz16bitMonoPCM = "riff-8khz-16bit-mono-pcm"
    case riff22050Hz16bitMonoPCM = "riff-22050hz-16bit-mono-pcm"
    case riff24kHz16bitMonoPCM = "riff-24khz-16bit-mono-pcm"
    case riff44100Hz16bitMonoPCM = "riff-44100hz-16bit-mono-pcm"
    case riff48kHz16bitMonoPCM = "riff-48khz-16bit-mono-pcm"

    public var id: Self { self }

    public static var defaultFormat: Self = .audio24kHz16bit48kbpsMonoOpus
}
