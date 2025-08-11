# 🎮 RedX Game Library

**Modern Steam Oyun Kütüphanesi ve Yöneticisi**

![Version](https://img.shields.io/badge/version-v1.4-red)
![Language](https://img.shields.io/badge/language-Python-blue)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey)

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [Dil Desteği](#-dil-desteği)
- [Sistem Gereksinimleri](#-sistem-gereksinimleri)
- [Katkıda Bulunma](#-katkıda-bulunma)
- [Lisans](#-lisans)

## ✨ Özellikler

### 🎨 Modern Arayüz
- **Kırmızı-Siyah Tema**: Şık ve modern görünüm
- **Responsive Tasarım**: Farklı ekran boyutlarına uyum
- **Animasyonlu Elementler**: Yumuşak geçişler ve efektler

### 🌍 Çoklu Dil Desteği
- 🇹🇷 **Türkçe** (Ana dil)
- 🇺🇸 **İngilizce**
- 🇩🇪 **Almanca**
- 🇷🇺 **Rusça**
- 🇯🇵 **Japonca**

### 🎮 Oyun Yönetimi
- **Oyun Arama**: Hızlı ve etkili arama sistemi
- **Tür Filtreleme**: Oyunları türlerine göre filtrele
- **Kurulum Takibi**: Yüklü oyunları görüntüle ve yönet
- **Steam Entegrasyonu**: Steam Store sayfalarına doğrudan erişim

### 🔧 Gelişmiş Özellikler
- **Otomatik Güncelleme**: GitHub üzerinden otomatik güncelleme kontrolü
- **Steam Yolu Tespiti**: Otomatik Steam klasörü bulma
- **DLC Desteği**: Oyun DLC'lerini yönetme
- **İlerleme Takibi**: İndirme ve kurulum ilerlemesi

## 🚀 Kurulum

1. [Releases](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases/latest) sayfasından en son `RedXGameLibrary.exe` dosyasını indirin
2. `RedXGameLibrary.exe` dosyasına çift tıklayarak çalıştırın
3. Kurulum gerektirmez!

## 📖 Kullanım

### İlk Başlatma
1. Uygulama açıldığında Steam yolu otomatik olarak tespit edilir
2. Eğer tespit edilemezse, manuel olarak Steam klasörünü seçin
3. Sayfa başına gösterilecek oyun sayısını belirleyin (önerilen: 9)

### Oyun Arama ve Filtreleme
- **Arama Kutusu**: Oyun adına göre arama yapın
- **Tür Filtresi**: Sağ panelden türleri seçerek filtreleyin
- **Filtre Uygula**: Seçimlerinizi uygulamak için "Filtrele" butonuna tıklayın

### Oyun Yönetimi
- **Oyun Ekleme**: Oyun kartındaki "Ekle" butonuna tıklayın
- **Oyun Silme**: Yüklü oyunlarda "Sil" butonunu kullanın
- **Steam'de Görüntüle**: Oyunun Steam sayfasını açın

### Dil Değiştirme
- Sağ paneldeki bayrak simgelerine tıklayarak dili değiştirin
- Dil değişikliği sonrası uygulama otomatik olarak yeniden başlar

## 🌍 Dil Desteği

Uygulama aşağıdaki dilleri destekler:

| Dil | Kod | Durum |
|-----|-----|-------|
| Türkçe | `tr` | ✅ Tam Destek |
| İngilizce | `en` | ✅ Tam Destek |
| Almanca | `de` | ✅ Tam Destek |
| Rusça | `ru` | ✅ Tam Destek |
| Japonca | `ja` | ✅ Tam Destek |

## 💻 Sistem Gereksinimleri

### Minimum Gereksinimler
- **İşletim Sistemi**: Windows 10 veya üzeri
- **RAM**: 4 GB
- **Depolama**: 100 MB boş alan
- **İnternet**: Aktif bağlantı gerekli

### Önerilen Gereksinimler
- **İşletim Sistemi**: Windows 11
- **RAM**: 8 GB
- **Depolama**: 500 MB boş alan
- **İnternet**: Hızlı bağlantı

## 📁 Proje Yapısı

```
RedXFreeSteamInstaller/
├── gui.py              # Ana GUI uygulaması
├── index.py            # Oyun indirme ve işleme modülü
├── languages.py        # Çoklu dil desteği
├── config.py           # Yapılandırma dosyası
├── changes.txt         # Değişiklik günlüğü
└── resources/          # Kaynak dosyalar
    ├── icon.ico        # Uygulama ikonu
    ├── games.json      # Oyun veritabanı
    ├── censored.png    # Sansür görseli
    ├── redx.dll        # Steam eklentisi
    └── flags/          # Bayrak görselleri
        ├── TRflag.png
        ├── ENflag.png
        ├── DEflag.png
        ├── RUflag.png
        └── JPflag.png
```

## 🤝 Katkıda Bulunma

1. **Fork** edin
2. **Feature branch** oluşturun (`git checkout -b feature/AmazingFeature`)
3. **Commit** edin (`git commit -m 'Add some AmazingFeature'`)
4. **Push** edin (`git push origin feature/AmazingFeature`)
5. **Pull Request** açın

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

## 🔗 Bağlantılar

- **GitHub**: [RedXFreeSteamInstaller](https://github.com/Scriptez1/RedXFreeSteamInstaller)
- **Releases**: [Son Sürümler](https://github.com/Scriptez1/RedXFreeSteamInstaller/releases)
- **Issues**: [Sorun Bildirimi](https://github.com/Scriptez1/RedXFreeSteamInstaller/issues)

## ⚠️ Uyarı

Bu uygulama eğitim amaçlıdır. Steam'in kullanım şartlarına uygun şekilde kullanın.

---

**RedX Game Library** - Modern Steam Oyun Yöneticisi 🎮