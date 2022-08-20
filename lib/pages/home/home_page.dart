import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungimobil/model/activity_model.dart';
import 'package:fungimobil/model/organization_model.dart';
import 'package:fungimobil/pages/home/components/home_drawer.dart';

import '../../constants/style.dart';
import '../../model/blog_model.dart';
import '../../model/category_item_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final String userName = 'Merhaba Furkan';
  final String appBarQuestion = 'Bugün ne yapmak istersiniz?';

  final int activityItemWidth = 220;
  final int activityItemHeight = 300;
  final int activityItemImageHeight = 250;

  final List<CategoryItemModel> categoryItemList = [
    CategoryItemModel('Etkinlikler', Icons.local_activity_outlined),
    CategoryItemModel('Blog', Icons.text_snippet_outlined),
    CategoryItemModel('Galeri', Icons.photo_outlined),
    CategoryItemModel('Alışveriş', Icons.shop_outlined),
  ];

  late List<ActivityModel> activityItemList;
  late List<OrganizationModel> organizationItemList;
  late List<BlogModel> blogItemList;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _setDatas();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        backgroundColor: Colors.grey.shade100,
        drawer: HomeDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Style.defaultPadding / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: Style.defaultPadding,),
                Padding(
                  padding: const EdgeInsets.all(Style.defaultPadding / 2),
                  child: _buildSearch(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(Style.defaultPadding / 2),
                  child: _buildCategories(context),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: Style.defaultPadding, horizontal: Style.defaultPadding / 2),
                  child: _buildActivityList(context),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: Style.defaultPadding, horizontal: Style.defaultPadding / 2),
                  child: _buildBlogList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _setDatas() {
    activityItemList = [
      ActivityModel('https://picsum.photos/$activityItemWidth/$activityItemImageHeight', 'Kütahya Mantar Kampı',
          'Kütahya, Dumlupınar', 100, 20, 12),
      ActivityModel('https://picsum.photos/$activityItemWidth/$activityItemImageHeight', 'Tavşanlı Mantar Kampı',
          'Kütahya, Tavşanlı', 175, 25, 10),
      ActivityModel('https://picsum.photos/$activityItemWidth/$activityItemImageHeight',
          'Türkiye Mantarcılar Buluşması', 'İstanbul, Fatih', 320, 75, 46),
      ActivityModel('https://picsum.photos/$activityItemWidth/$activityItemImageHeight', 'Yalova Mantar Kampı',
          'Yalova, Merkez', 110, 28, 3),
    ];
    organizationItemList = [
      OrganizationModel(
          'https://www.fungiturkey.org/Image/Services/6.09.2021-5988771.jpg',
          'Mantar Avcılığı Eğitimleri',
          'Etkinliklerle gerçekleştirdiğimiz bu eğitimlerde sahada uzmanlar eşliğinde mantar toplayacak, yenebilir ve zehirli türleri birebir tecrübe ederek öğreneceksiniz.'),
      OrganizationModel('https://www.fungiturkey.org/Image/Services/6.09.2021-3471444.jpg', 'Kişiye Özel Eğitimler',
          'Birebir detaylı anlatımlarla ilerleyeceğimiz bu eğitimlerde programı siz belirleyebiliyorsunuz. Detaylı bilgi için bizimle iletişime geçiniz. '),
      OrganizationModel(
          'https://www.fungiturkey.org/Image/Services/6.09.2021-2252062.jpg',
          'Online Mantar Avcılığı Eğitimi',
          'Türkiye\'de ilk kez bizim tarafımızdan yapılan bu eğitimle mantarların dünyasını, habitatlarını, çeşitlerini, benzerliklerini, mevsimlerini ve bunlar gibi birçok konu hakkında bilgi sahibi olacaksınız. Eğitim yaklaşık 4 saat kadar sürmektedir, Skype üzerinden online olarak yapılmakta olup katılımcılara PDF formatında "Mantar Avcılığı Rehberi"ni hediye etmekteyiz.'),
      OrganizationModel(
          'https://www.fungiturkey.org/Image/Services/26.10.2021-8937290.jpg',
          'Kurumsal Fungi-Gastro Etkinlikleri',
          'Eğitim kurumlarına veya kurumsal şirketlere yönelik özel etkinlik programlarıyla mantar türlerini öğrenerek lezzetleriyle de unutulmaz bir deneyim yaşayacaksınız.'),
      OrganizationModel(
          'https://www.fungiturkey.org/Image/Services/6.09.2021-7523978.jpg',
          'Mantar Avı Ve Gastronomisi Etkinliği (Kamplı)',
          'Eğitim kurumlarına veya kurumsal şirketlere yönelik özel etkinlik programlarıyla mantar türlerini öğrenerek lezzetleriyle de unutulmaz bir deneyim yaşayacaksınız.'),
    ];
    blogItemList = [
      BlogModel(
        'https://picsum.photos/$activityItemWidth/$activityItemImageHeight',
        'Mantar Avcılığı İçin Gerekli Ekipmanlar',
        '''Mantar avcılığı yapabilmemiz için ekipmanlara ihtiyacımız vardır. Bu ekipmanların olmazsa olmazı sepet, çakı ve fırçadır. Diğer ekleyeceğimiz ekipmanlar ise bizim konforumuz ve güvenliğimiz açısından önem taşımaktadır.

Hasır Örme Sepet

Mantar avına çıkıyorsak kesinlikle yanımızda sepet bulundurmalıyız. Bilinçli bir mantar avcısı topladığı mantarları kesinlikle poşete koymaz. Mantarlar hızlı bozulan bir besindir, poşete koyulmuş mantarlarda bu süre daha hızlı işlemektedir, bu yüzden poşette bozulan mantarlar sizi zehirleyebilir. Ayrıca poşetteki mantarlar estetik açıdan da zarar görecektir ve temizlemesi de zorlaşacaktır.

Hasır örme sepetler bu iş için en ideal olanıdır. Kapaklı hasır sepet bile tercih edebilirsiniz çünkü her yerinden hava alacaktır ve sepetin üstünden girebilecek yaprak vb. cisimlerin de önüne geçmiş olursunuz. Ya da normal bir örme sepet de işinizi çok rahat görecektir.

Sepete koyduğunuz mantarlar estetik açıdan hiçbir zarara uğramayacaktır ve birbirlerini de kirletmeyeceklerdir. En önemlisi de doğada gezerken sepetinize koyduğunuz mantarların sporları çevreye yayılarak yeni misel oluşumlarına katkıda bulunacaksınız.

Sepetinizdeki mantarlar estetik durduğu için çok güzel fotoğraflar elde edebilir ve bu resimleri paylaşabilirsiniz. Bu şekilde yapmış olduğunuz avdan daha keyif alacaksınız ve çevrenize örnek bir davranış sergilemiş olacaksınız.

Çakı

Çakı ve benzeri bir araç doğada en ihtiyaç duyulan ekipmanlardan birisidir. Mantar avcısı için de özellikle önem taşımaktadır. Mantarların dip kısımlarını kesip sepetimize temiz ve topraksız bir şekilde koymamızı sağlayacaktır. Ağaçta olan mantar türleri için de mutlaka gereklidir. Örneğin bir istiridye mantarına denk geldik, yapısı gereği biraz narin ve hassastır bu tür. Bu mantarı elimizle koparıp almamız doğru olmayacaktır, her ne kadar dikkat etsek de olur olmadık yerden koparak parça parça elimizde kalabilir. Çakı gibi bir aletle keserek aldığımızda estetik açıdan zarar görmeden sepetimize koyabiliriz.

Mantarın kurtlu olup olmadığını keserek anlayabiliriz. Çakı yardımı ile mantarı ikiye ayırarak kurtlu bölgelerini tespit edebilir ve küçük bir bölgeyse de temizleyerek sepetimize atabiliriz.

Eğer mantarları kopararak temizlemeye çalışıyorsak olur olmadık yerlerden kopabilir ve canınızı sıkabilir. Bazı mantarların sapları o kadar liflidir ki koparmak bile işe yaramayabilir, böyle türleri mutlaka keserek almamız gerekecektir.

Fırça

İlk defa duyanlara tuhaf gelebilir ama fırça bu avcılığın en önemli parçalarındandır. Bu fırça mantarı çizecek kadar ne sert olmalıdır ne de mantarın temizleyemeyecek kadar yumuşak olmalıdır. Orta sertlikte bir fırça işinizi görecektir.

Fırçayı kullanma amacımız mantarın üzerinde bulunan habitat kalıntılarını bulunduğu yerde temizleyerek sepetimize koymaktır. Bu sayede mantar temizliğinin büyük bir kısmını olduğu yerde halletmiş oluruz. Aksi taktirde temizlemediğimiz mantar sepetteki diğer mantarları da kirleterek temizlik için işimizi daha da zorlaştıracaktır.

Mantar avcıları için arkasında fırça bulunan özel çakılar mevcuttur. Yanında ekstradan fırça taşımak istemeyenler için idealdir fakat fırçası çok küçük olduğundan dolayı temizlik işi biraz uzun sürebilir.

GPS ve Telsiz

Mantar peşinde geçen zamandan ve gidilen yoldan bazen bihaber oluruz. Her yıl sık sık karşılaşıyoruz, ormanda kaybolanlar ve günlerce aranıp bulunamayanlar oldukça fazla. Gittiğimiz bölgeyi çok iyi bilmeliyiz veya bilen birisiyle gitmeliyiz. Keşif için gidiyorsak gideceğimiz yere mümkünse uydu ile çalışabilen haberleşme cihazı ve GPS gibi rotamızı belirleyebileceğimiz araçlar hayati derecede önemlidir.

Muhtemelen gittiğiniz bölgede telefonunuz çekmeyecektir. Genelde birkaç kişi mantar avına gidildiğinde biri mantar bulduğunda onunla ilgilenirken diğeri veya diğerleri yoluna devam edecektir, geride kalan orada fazla vakit geçirdiyse diğerlerinin izi çoktan kaybolacaktır. Bu şekilde ekip olarak gidiyorsanız telsiz bulundurmanız haberleşmeniz ve birbirinizi kaybetmemeniz açısından mutlaka gereklidir.

Eğer bu imkanlara sahip değilsek başlangıç noktamızdan çok uzaklaşmayıp gittiğimiz yönleri ezberlemeli ve dönüş için işaret bölgeler belirlemeliyiz. Gittiğimiz konum bilgisini mutlaka bir yakınımızla paylaşmalı ve dönüş zamanını belirtmeliyiz. Aksi durumlarda belirttiğiniz konuma göre sizi arayacaklarını unutmayınız.

Bot ve Kıyafet

Orman koşullarında ayakkabı kullanmak pek uygun değildir. Ayağınızın içine girebilecek habitat kalıntıları canınızı sıkacaktır. Genelde nemli ve ıslak olan orman zemininden de ayaklarınız etkilenecektir. Bu iş için uygun olanı, en az dört parmak ayak bileğinizi geçecek şekilde bir bot kullanmaktır. Askeri tip botlar dayanıklılık, konfor ve su geçirmezlik gibi özelliklerinden dolayı benim tercih sebebimdir. Sıcak havalarda kullanmak için yazlık bot, soğuk ve yağışlı havalarda kullanmak için de kışlık bot ihtiyacımı en iyi şekilde karşılamaktadır. Siz de kendinize en uygun olanı seçerek başlayabilirsiniz.

Konforumuz ve sağlığımız açısından uygun kıyafetleri tercih etmeliyiz. Yırtılmalara, takılmalara ve suya dayanıklı esnek bir pantolon rahatınız ve konforunuz açısından önemlidir. Pantolon paçalarının lastikli olmasıyla da bot üzerini kapatıp kene vb. zararlılardan kendinizi korumuş olursunuz.

Üzerinize uzun kollu ve yakası çok açık olmayan giysileri tercih ediniz. Dış etkenlerden kollarınızı korumuş olur ve çok açık olmayan yaka sayesinde de kene gibi zararlıların içinize girmesini minimuma indirgersiniz.

Genelde av sırasında şapka kullanmaya özen gösteriyorum, çünkü ormanda gezerken sürekli saçıma, enseme ve gözüme bir şeyler gelebiliyor. Şapka kullanmak sizleri de bu gibi durumlara karşı rahat ettirecektir.

Yabani Hayvan Kovucu

Şehre yakın bölgelerde pek denk gelmesek de biraz daha kırsal alanlarda karşılaşma olasılığımız oldukça yüksektir. Özellikle büyük ormanlarda ve yüksek rakımlarda dikkatli olmalıyız aksi taktirde ava giderken avlanabiliriz.

Genelde yabani hayvanlara denk geldiğimizde onlar hızla uzaklaşarak kaçarlar ama durum her zaman böyle olmayabilir. Örneğin yavrusu olan bir ayı ile aniden karşılaşırsanız muhtemelen sizi tehdit olarak algılayıp saldırıya geçecektir. Bu gibi durumların önüne geçmek için ormanlarda ses çıkararak ilerlemek en ideal olanıdır. Bu şekilde sizi duyan yaban hayvanları yakınlarınızdan uzaklaşır ve karşılaşmazsınız.

Yabani hayvanları uzaklaştırmak için kullanılabilecek bazı teknolojik cihazlar da mevcut fakat taşıması pek keyifli olmayabilir. Eğer kamp yapıyorsanız bu cihazları çadırınızın yanına konumlandırabilirsiniz. Yaban hayvan kovucu bazı kimyasal ürünler de mevcuttur bunları da tercih edebilirsiniz. Ek olarak biber gazı da bulundurabilirsiniz. Ani karşılaşmalarda ve aksi durumlarda biber gazını kullanmak kaçmak için zaman kazandıracaktır.''',
        '24 Ağustos 2021',
        'Ömer Üngör ',
      ),
      BlogModel(
          'https://picsum.photos/$activityItemWidth/$activityItemImageHeight',
          'Ticari Amaçlı Mantar Avcılığı',
          '''Dünya çapında ülke ekonomilerine ciddi katkılar sağlayan mantarlar birçok ailenin de geçim kaynağıdır. Bazı ülkelerde milyonlarca dolar değerinde yapılan ihracatlar ülke ve aile ekonomilerine ciddi katkılar sağlamaktadır. Ülkemizde de bu tarz ticari avcılık var fakat diğer ülkelerin oldukça gerisindedir. Bunun sebepleri oldukça fazla ama en önemlisi mantarları tanımıyor olmamızdan kaynaklanıyor.

Ülkemizde yapılan bu ticari faaliyetlerden bahsedeyim öncelikle. Birçok ülkeye ihraç ettiğimiz türlerin başında porçini mantarları (Boletus edulis, Boletus aereus, vb.), kuzu göbeği mantarları (Morchella esculenta, Morchella elata, vb.), sarıkız/kazayağı mantarı (Cantharellus cibarius) ve diğer mantarlar yer almaktadır. Bunlara ek olarak toprak altında yetişen trüf mantarları (Tuber aestivum, Tuber borchii, vb.) da ekonomiye oldukça katkı sağlamaktadır ama bu türler için eğitimli özel bir köpeğe ihtiyaç duyulmaktadır.

Bu piyasa ülkemizde yeterli seviyede olmasa da ticareti için aracılığını yapan ve ihraç eden firmalar maalesef pastadan inanılmaz bir pay almaktadırlar. Asıl amaç halkı kalkındırmak ve aile ekonomisine gelir sağlayabilmekken bu tüccarlar neredeyse 10’da 1’ini avcılığını yapan vatandaşa ödüyorlar. Bu yüzden ticari değerini bilen vatandaşlar bile bu rakamlara avcılık yapmak istemiyorlar. Sabahtan akşama kadar 3-5 kilo mantar toplayabilen avcılar kilo başına 10 birim para kazanırken tüccarlar da bu tutarı neredeyse 10'a katlıyor.

Hatta öyle tüccarlar var ki bunun için insan öldürecek kadar gözleri dönmüş. Ticari amaçlı avcılığını yapan birisiyle sohbet ederken bu konuyla ilgili başından geçenleri bana anlattı. Porçini mantarı toplamak için gittiği ormanda bir iki kasa kadar mantar toplayabilmiş fakat siparişleri için yeterli olmamış ve başka da bulamamış. Mantarları gören tüccarlar yanına gitmiş ve oldukça düşük bir fiyat vermişler, kendisi de mantarların satılık olmadığını söylemiş. Yaklaşık 500m kadar ileri gidince orada mantar toplayan köylüleri görmüş, kalan siparişi kadar mantarı satmaları için ricada bulunmuş ve hakkıyla parasını ödeyerek almış. Bir önceki yerdeyken kendisinden düşük ücretle mantarları isteyen tüccarların gözünden kaçmamış, köylüden para verip mantarları aldığını görmüşler. Yanına giderek etrafını sarmışlar, hakaretler edip ciddi şekilde darp etmişler. Bununla da kalmayan tüccarlar, arabasını ateşe verip yakmak istemişler ama yanlışlıkla kendi aracına benzeyen başka bir aracı yakmışlar. Canını zor kurtararak hemen oradan ayrılmış ama yıllardır da unutamamış.

Mantar avcısı ve gezgin bir arkadaşımız da gezdiği bir bölgede köylülerin kuzugöbeği mantarı topladığını görmüş. Yanlarına giderek selam vermiş, satıyor musunuz yoksa yiyor musunuz diye merak ederek sormuş. Köylülerden aldığı cevap karşısında çok şaşırmış, tüccarlar bu mantarın zehirli olduğunu ve sadece ilaç fabrikalarında kullanmak için onlara toplattığını söylemişler, tüccarların kg için ödedikleri para ise piyasa fiyatının 20’de 1’i kadarmış. Mantarlar hakkında köylüyü bilinçlendiren arkadaşımız mantarın gerçek değerini ve yenebilirliğini anlatarak, tüccarlara vermemeleri konusunda köylüyü uyarmış.

Bu tarz örnekler ülkemizde oldukça fazla ve saymakla bitmiyor. Bu ticari türler hakkında halkı eğitimlerle bilinçlendirebilirsek bunların önüne geçmiş olur hem aile hem de ülke ekonomisi açısından ciddi bir gelir kapısını da aralamış oluruz.''',
          '23 Ağustos 2021',
          'Ömer Üngör'),
      BlogModel(
          'https://picsum.photos/$activityItemWidth/$activityItemImageHeight',
          'Can Alıcı Hurafeler',
          '''Her geçen gün çok farklı uydurma bilgiler ve hurafeler duyuyorum, bazen gülsem mi üzülsem mi diye kararsız kalıyorum bunlara karşı. Aslında bu hurafeler tüm dünyada oldukça yaygındır ve bunlar nesilden nesile aktarılır, bu sayede de coğrafyalarda inanılmaz bir yayılış gösterir.

En klasik ve en bilineni, hatta binlerce kişinin canına da mal olmuş olanı “zehirli mantar kurtlanmaz, sülük ve böcek de yemez” dir. Bu bilgiyi uyduran ve bunun yayılmasına vesile olanların tabiri caizse yatacak yeri yoktur. İnsanlar ile böceklerin vücut sistemleri farklıdır, bize zararlı olabilecek mantarlar onlar için ziyafet olabilir. Ayrıca her ava çıktığımda kurtlanmış ve böcekler tarafından yenmiş zehirli türleri sürekli görüyorum, sizlerde mutlaka denk geleceksiniz.

Zehirli mantarlar acıdır veya tadı kötüdür hurafesi de yaygındır. Rahmetliler köygöçüren mantarının (Amanita phalloides) tadının çok lezzetli olduğunu söylüyorlar, bunun aksine yenebilir tür olan biberli mantar (Lactarius piperatus) oldukça acıdır.

Pişirdiğiniz mantarların içine gümüş atın, eğer mantar zehirliyse gümüş renk değiştirir hurafesi de vardır. Hiçbir mantar gümüşle reaksiyona girmez ve renk değiştirmez.

Mantarları haşlayın, pişirin, kurutun, turşusunu yapın zehirliliği gider gibi bir inanış da var. Ölümcül birçok mantarın içeriğinde amatoksin mevcuttur ve bu amatoksin hiçbir şekilde nötralize olmaz. Ülkemizde genelde mantarları önce haşlayarak tüketirler, bu da zehirliyse zehri gitsin hurafesinden kaynaklanmaktadır. Bazı türlerin yenebilmesi için iyi pişirilmesi gerektiği bir gerçek ama bunu bütün genele yaymak mantık dışıdır ve bu gibi durumlar ölümle sonuçlanabilir.

Bunlar gibi hurafelerin sonu gelmemektedir, mantarlarla ilgili bütün genellemeler yanlıştır ve yenebilirliğin bir kalıbı yoktur. Yenebilir türlere benzer zehirli türler olduğunu unutmayınız. Lütfen bilimsel olarak yenebilirliği kanıtlanmış türleri tüketmeye dikkat ediniz.''',
          '23 Ağustos 2021',
          'Ömer Üngör'),
      BlogModel(
          'https://picsum.photos/$activityItemWidth/$activityItemImageHeight',
          'Mantar Toplanmaması Gereken Yerler',
          '''Toplayacağımız mantarların nerede yetiştiği ve nereden topladığımız sağlımız açısından çok önemlidir. Bu yüzden nereden toplamamamız gerekiyor bunları çok iyi bilmeli ve dikkat etmeliyiz.

Şehir içi ve yol kenarlarında çıkan mantarları tüketmek risklidir. Mantar miselyumu havadaki ağır metalleri ve toksik bileşenleri bünyesinde barındırma özelliğine sahiptir.

Mezarlıklardan da mantar toplanmaz, bunun için açıklama yapmama gerek bile yok. İlaçlama ve gübreleme yapılan tarla, meyve bahçeleri, fındık bahçeleri ve sebze bahçelerinden kesinlikle mantar toplamayınız, buralardan toplayacağınız mantarlar muhtemelen oradaki toksik bileşenleri bünyesine alacaktır.

Lağım, çöp ve çöplere yakın olan mantarlardan da kaçınmak lazım, bunlardan sızabilecek toksikleri ve sıvıları da bünyesine alabilir.''',
          '23 Ağustos 2021',
          'Ömer Üngör')
    ];
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: Style.defaultPadding * 2 + Style.defaultIconSize,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(top: Style.defaultPadding / 2),
        child: IconButton(
          splashColor: Colors.transparent,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Style.secondaryColor,
            size: Style.defaultIconSize,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: Style.defaultPadding / 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Style.textColor,
                  ),
            ),
            // const SizedBox(
            //   height: Style.defaultPadding / 4,
            // ),
            Text(
              appBarQuestion,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Style.textColor.withOpacity(0.4),
                  ),
            ),
          ],
        ),
      ),
      actionsIconTheme: const IconThemeData(
        size: Style.defaultIconSize + Style.defaultPadding * 2,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(
              top: Style.defaultPadding / 4, bottom: Style.defaultPadding / 4, right: Style.defaultPadding),
          child: CircleAvatar(
            child: Icon(
              Icons.person_outline,
              color: Style.primaryColor,
              size: Style.defaultIconSize,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        prefixIcon: Icon(
          Icons.search,
          color: Style.textColor.withOpacity(0.4),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Style.defaultRadiusSize), borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Style.textColor.withOpacity(0.2),
            ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < categoryItemList.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: Style.defaultPadding),
              child: Chip(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                ),
                label: Row(
                  children: [
                    Icon(
                      categoryItemList[i].icon,
                      size: Style.defaultIconSize,
                    ),
                    const SizedBox(
                      width: Style.defaultPadding / 2,
                    ),
                    Text(
                      categoryItemList[i].title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Style.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          // ListView.separated(
          //   shrinkWrap: true,
          //   scrollDirection: Axis.horizontal,
          //   itemCount: categoryItemList.length,
          //   separatorBuilder: (context, index) {
          //     return SizedBox(
          //       width: Style.defaultPadding,
          //     );
          //   },
          //   itemBuilder: (context, index) {
          //     return Chip(
          //       label: Row(
          //         children: [
          //           Icon(
          //             categoryItemList[index].icon,
          //             size: Style.defaultIconSize,
          //           ),
          //           SizedBox(
          //             width: Style.defaultPadding / 2,
          //           ),
          //           Text(
          //             categoryItemList[index].title,
          //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Style.textColor),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Column _buildActivityList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Etkinlikler',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Style.textColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: Style.defaultPadding,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < activityItemList.length; i++) _buildActivityCard(activityItemList[i], context),
              // ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: activityItemList.length,
              //     itemBuilder: (context, index) {
              //       var model = activityItemList[index];
              //       return _buildActivityCard(model, context);
              //     }),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildActivityCard(ActivityModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Style.defaultPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          height: activityItemHeight.toDouble(),
          width: activityItemWidth.toDouble(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                  model.imageUrl,
                  width: activityItemWidth.toDouble(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(Style.defaultPadding / 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                model.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Style.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.red.shade900,
                                  size: Style.defaultIconSize * 0.7,
                                ),
                                const SizedBox(
                                  width: Style.defaultPadding / 4,
                                ),
                                Expanded(
                                  child: Text(
                                    model.location,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Style.textColor.withOpacity(0.7), wordSpacing: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: Style.defaultPadding / 3,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Text(
                              '${model.price.toStringAsFixed(2)}₺',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.blue.shade800,
                                  ),
                            ),
                          ),
                          const Spacer(),
                          Flexible(
                            child: Text(
                              '${model.currentSavedPerson}/${model.quota}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Style.textColor.withOpacity(0.7),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Blog',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Style.textColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(1000),
              splashColor: Style.secondaryColor,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(Style.defaultPadding / 2),
                child: Text(
                  'Tümünü gör',
                  style: Theme.of(context).textTheme.button?.copyWith(color: Style.secondaryColor),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: Style.defaultPadding,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: blogItemList.length,
          itemBuilder: (context, index) {
            var model = blogItemList[index];
            return _buildBlogListItem(model, context);
          },
        ),
      ],
    );
  }

  Widget _buildBlogListItem(
    BlogModel model,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Style.defaultPadding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(Style.defaultPadding / 2),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: 150 - Style.defaultPadding,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
                    child: CachedNetworkImage(
                      imageUrl: model.imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    /*CachedNetworkImage(
                  imageUrl: */ /*model.imageUrl*/ /* 'https://picsum.photos/200/300',
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    debugPrint(error.toString());
                    return Container(color: Colors.red,);
                  },
                  progressIndicatorBuilder: (context, url, progress) {
                    return Text('${progress.downloaded} / ${progress.totalSize}');
                  },
                ),*/
                  ),
                ),
                const SizedBox(
                  width: Style.defaultPadding,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Style.defaultPadding / 2,
                      ),
                      Text(
                        model.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold, color: Style.textColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: Style.defaultPadding,
                      ),
                      Flexible(
                        child: Center(
                          child: Text(
                            model.content,
                            style: Theme.of(context).textTheme.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          model.releaseDate,
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: Style.secondaryColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Column _buildOrganizationList(BuildContext context) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Flexible(
//             child: Text(
//               'Organizasyonumuz',
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: Style.textColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ),
//           InkWell(
//             borderRadius: BorderRadius.circular(1000),
//             splashColor: Style.secondaryColor,
//             onTap: () {},
//             child: Padding(
//               padding: const EdgeInsets.all(Style.defaultPadding / 2),
//               child: Text(
//                 'Tümünü gör',
//                 style: Theme.of(context).textTheme.button?.copyWith(color: Style.secondaryColor),
//               ),
//             ),
//           )
//         ],
//       ),
//       const SizedBox(
//         height: Style.defaultPadding,
//       ),
//       ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: organizationItemList.length,
//         itemBuilder: (context, index) {
//           var model = organizationItemList[index];
//           return _buildOrganizationCard(model, context);
//         },
//       ),
//     ],
//   );
// }
//
// Padding _buildOrganizationCard(OrganizationModel model, BuildContext context) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: Style.defaultPadding),
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(5),
//       child: Container(
//         color: Colors.white,
//         width: double.infinity,
//         height: 150,
//         child: Padding(
//           padding: const EdgeInsets.all(Style.defaultPadding / 2),
//           child: Row(
//             children: [
//               SizedBox.square(
//                 dimension: 150 - Style.defaultPadding,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(Style.defaultRadiusSize),
//                   child:
//                     // Image.network(activityItemList[0].imageUrl),
//                   CachedNetworkImage(
//                     imageUrl: activityItemList[0].imageUrl,
//                     imageBuilder: (context, imageProvider) => Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: imageProvider,
//                             fit: BoxFit.cover,
//                             colorFilter:
//                             ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//                       ),
//                     ),
//                     placeholder: (context, url) => CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => Icon(Icons.error),
//                   ),
//                   /*CachedNetworkImage(
//                     imageUrl: *//*model.imageUrl*//* 'https://picsum.photos/200/300',
//                     fit: BoxFit.cover,
//                     errorWidget: (context, url, error) {
//                       debugPrint(error.toString());
//                       return Container(color: Colors.red,);
//                     },
//                     progressIndicatorBuilder: (context, url, progress) {
//                       return Text('${progress.downloaded} / ${progress.totalSize}');
//                     },
//                   ),*/
//                 ),
//               ),
//               const SizedBox(
//                 width: Style.defaultPadding,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: Style.defaultPadding,
//                     ),
//                     Flexible(
//                       child: Text(
//                         model.title,
//                         style: Theme.of(context)
//                             .textTheme
//                             .titleMedium
//                             ?.copyWith(fontWeight: FontWeight.bold, color: Style.textColor),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: Style.defaultPadding,
//                     ),
//                     Flexible(
//                       child: Text(
//                         model.content,
//                         style: Theme.of(context).textTheme.bodyMedium,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
}
