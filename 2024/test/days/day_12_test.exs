defmodule Day12Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day12

  @test_example """
                AAAA
                BBCD
                BBCC
                EEEC
                """
                |> String.trim()

  test "calculates part1 example" do
    assert @test_example |> Day12.part1() == 140
  end

  test "calculates part1 example 2" do
    assert test_input() |> Day12.part1() == 1930
  end

  test "calculates part1 actual" do
    assert test_actual() |> Day12.part1() == 1_473_276
  end

  def test_actual do
    """
    MMNNPPPPGGGGAGGPPPPPPPPPZZZZZZZLLLLLLLEEEEEEEEEEEEEEEAAAAAAAAAAAAAAAAAAAAMMMMNNMMMMMMMMMMMMMMMMAARRRRRRRRRRRRRRRRRRHHHHHHHHHHHHHAAAAAAAAAAAA
    MNNNPNPPGGGGGGGPPPPPPPEPZZZZZZZLLLLLLLWWEEEEEEEEEEEEEAPAAAAAAAAAAAAAAAAAAMMMMMMMMMMMMMMMMMMMAMMAARRRRRRRRRRRRRRRRQRHHHHHHQHHHHHHHWAAAAAAAAAA
    NNNNNNNPGGGGGGGGPPPPPPPZZZZZZZZZLLLLLLLEEEEEEEEEEEEEEPPPPAAAAAAAAAAAAAAMMMMMMMMMMMMMMMMMMMMMAAAAAAAAAVRRRRRRRRRQQQQHHQQHQQQHQHHHHWWWWAAAAAAA
    NNNNNNNNGGGGGGGPPPPPPPPPZZZZZZLLLLLLLLLLEEEMEEEEEEEEEEPPPPAAAAAAAAAAAMMMMMMMMMMMMMMMMMMMMMMMMAAAAAAVVVVRRRRRRRQQQQXQQQQQQQQQQQQHHHWWWWWAAAAA
    NNNNNNNYYGGGGGGPPPPPPPPPZZZZZZZLLLLLLLLMMMMMEEEEEEEEEPPPPPPAAAAAHAAAAMMMMMMMMMMMMMMMMMMMMMMMMMMAVVVVVVVRRRRRQQQQQQQQQQQQQQQQQQQHHWWWWAAAAAAA
    NNNNNNNXYYYCCCIPPPWZPPPPPZZZZZZLLLLLLLSSMMSSEEEEEEEPPPPPPPPPPAAHHAAAAHMMMMMMMMMMWWMMMMMMMMMMMMMMMDDVVVVRRRRRRQQQQQQQQQQQQQQQQQQHHWWWWWAWAAAA
    NNNNNNXXYCCCCCIPPPPZZPPPZZZZZZZZLSLSSSSMMMSSEEEEEEEPPPPPPPPPPPAAHHAAAHHMMMMMMMMMMWMTTMMMMMMMMMMDDDDVVVVRRIIMRMMMQQQHTTQQQQQQQQQQQWWWWWWWWWWA
    NNNXXXXXXCCCCCCXPZPZZZPZZZZZZZZZZSSSSSSSSSSSEEEEEEEEPPPPPUUXXXHAHHHAHHHMMTMMMTMMMMTTTMMMMMMMMMDDDDDVIIIRIIMMMIMZQQQHTHQQQQQQQQQQAAWWWWWWWWAA
    NNNNXXXXCCCCCCCZZZZZZZZZZZZZZZSSSSSSSSSSSSSSSSEEFFPPPPPUUUXXXHHHHHHHHHHHTTMMMTMMMMTTTTTMMMMMMDDDIDDVIIIIIIIMMMMMQQQHHHQQQQQQQQQQAAAWWWWWAWAA
    NNNNNXXXXCCCCCAVVZZZZZZZZZZZUUUSSSSSSSSSSSSSSFEFFFFPPPPUUUXXXXHHHHHHHHHHHTMTTTTTMMTTTTTTMMMDMDDIIIVVIIIIIIIMMMMMMQQHHQQQQQQQQGGGQAAAWWWAAAAA
    NNNNNXXXCCCCCVVVVVVZZZZZZZZUUUUSSSSSSSSSSSSSFFFFFFFPPPUUUUXUXHHHHHHHHHHHHTTTTTTTMMTTTTTTMMDDDDDDIIIIIIIIIIIMMMMMMQIHAQQQQQQQQQQQQAAAAAWAAAAA
    NNNNNNXCCCCCCCVVVVZZZZZZZZZUUUUSSSSSSSSSSSSSSFFFFFFPPPUUUUUUXHHHHHHHHHHHHHTTTTTTTTTTTTTTTTTDDDAAAAIAIIIIMMMMWMMDDGGGAQQQQQQQQQQQQQAAAAAAAAAA
    NNNNNNNCCCCCCCCVVZZZZZZZUZZUUUUSSSSSSSSSSSFFFFFFFFFFPPUUUUUUUHHHHHHHHHHTTTTTTTTTTTTTTTTTTTDDVVAAAAAAIIIIIIIMMTTDDGGGAQQQQQQQQQQWWWUUUAUUUAAA
    NNNNNNNNCCCCCCCCVVZZZZZZUUZUUUUSSSSSSSSSSSSSFFFFFFFFPPUUUUUUHHHHHHHHHHHHHHTTTTTTTTTTTTTTTTTDVVXAAAAAIIIIIIIMTTTTTTTGGQQQQQQQQQQWWWUUUUUAAAAA
    NNNNNNNNNNNCCCCCCCZZZZZZUQUUUUUUUSSSSSSSSXSSOFFFFFFFFPPPPUOOHHHHHHHHHHHTTTTTTTTTTTTTTTTTTTTDVVVAAAAAAIIIIIIMTTGTTGGGGQQQQQQQQQQWWWUUUUUUAAAA
    NNNNNNNNNNCCCCCCCCZZZZZUUQUUUUUUUSSSSSSSSSSOOOOFPFPFPPPPPPPPPPHHHHLHHHHTTTTTMMMTTTTTTTUTTTTDDVVVVAAAAIIIIIIMTTTTTGGGGQGGGQQCQQWWWWUUUUUUUUUA
    NNNNNNNNNNNNCCCCCBBMZZZUUUUUUUUUUSSSSSSSSOOOOBBPPPPFPPPPPPPPPPXHHHHHHHHTTPTTMMMTTTTUTUUUUUUUVVVVVVVAAAIIIIIITTTTTGGGGGGGGQFFWWWWWWUUUUUUUUUU
    NNNNNNNNTNCCCCCCBUBBHCCCUUKUUUUUSSSSSSSSOOOOOBBPPPPPPBPPPPPPPPHHHSSSSHPPPPPMMMMMTTTUUUUUUUUOUVVVVVVAAIIIIIIITTTTGGGGGGGGGFFFWWWWUUUUUUUUUUUU
    NNNNNNNWCCCCCCCBBBBBBCCCCCUUUUUUSSSSSRRRROROOOBBBBBBBBBBPPBBBBHSSSSSSSPPPPPMMMMMTTUUUUUUUUUUUVVVVVVVVVVVVXIITTTGGGGGGGFFFFFFSSKWUUUUUUUUUUUU
    NNNNNWWWWCCCCCCCBBBBHCCCCCUUUUUUUSSTGRRRRRRRRBBBVBBBBPPPPPBBBBSSSSSSSSPPPPPPMMMMMTTUUUUUUUUUUVVVVVVVVVVVVXXUUGGGGGGGGGFFFFFNSSKKJUUUUUUUUUUU
    MMMWWDWWIWWCCCCBBBBBBCCCCCCCCCCCCCGGGGRRRRRRRVVVVBBXXXXXPPBBSSSSSSSSSPPPPPPPMMMMMUTUUUUUUUUUUUUVVVVVXXXXXXXUUGGGGGGGGGFFFFFSSKKKJUUUUUUUUUUU
    MMMMWWWWWWWCCCCBQBBBBCCCCCCCCGGCGGGQGGRRRRRRRVZZZZZXXXXXBBBSSSSSSSPSPPPPPPPPPMMMMUUUUUUUUUUUUUUFVVVVXXXXXXXUUUUGGXGGGGGFFFFAAAKKJUUUUUUUUUUU
    MWWWWWWWWWCCCCCCQBQBCCCCCCCCCCGCGGGGGGRRRRRVVVVVZZZXXXXXZBBSSSSSSSPPPPPPPPPPPMMMMMUUUUUUUUULFFUFFVXXXXXXXXXUUUUGXXGGGEFFFKKKKAKKKKKUUUUUUUUU
    WWWYWWWWWWKCCCQCQQQCCCCCCCCCCGGGGGGGGGGGGGGVVVVVVZZXXXXXZZBBSBBSSSPPPPPPPPPEEMMMMMGUUUUUUUULFFFFVVXXXXXXXXXUUUUUBBUUGEFFFKKKKKKKKKUUUUUUUUUU
    WWWWWWWWWWWQQQQQQQQCCCCCCCCCCGGGGGGGGGGGGGGVVVVVVVZXXXXXKKKBBBBSSSSUUPPPPPPEMMSMMGGVAAAUUQFFFFFFVVVVVXXXXXUUUUBBBUUREEEMMKKKKKKKKKKKUUUUUUUU
    RWWWWWWWWWWQQQCQQQCCCCCCCGGGGGGGGGGGGGGGGGVVVVVVVVVXXXXXKKKKKBBBBBSSUPPPPPSMMMSSMMGVVVVVVQFFFFFFFFVVVXXXXXUUBUBBBBBREEEMMMMKKKKKKKKKUHUUUUUU
    WWWWWWWWWWWQCCCQQQQCCCCCCCCCGGGGGGGGGGGGGGGVVVVRVVRXXXXXKKKKBBBBBBBBPPPPPPSSSSSSMMMVVVVVVVFFFFFFFFFFFXXHXUUBBBBBBBRRREMMMMMKKKKKKKKKKHHHUUUU
    WWWWWWWWWWWCCCCQQQCCCCCCCCCIGIIGGGGGGWGGGGVRRRRRRRRXXXXXKKKKKKKBPBBPPPPPPSSSSSSSSMVVVVVVVVVVFFFFFFFFFHHHUUBBBBBBBRRRMMSMMMKKKKKKKKKKKUHUUUUU
    WWWWWWWWWWWWCCCCCCCCCCCCCCIIIIGGGGGGGWGGGVVRRRRRRRXXXXXXKKKKKBBBPPBPPRPPPPPSSSSSSVVVVVVVVVVVAFFFFFFFFFHHHHIBBBBBRRRRMMMMMMSKKKKKKKKVVUUUUUUU
    WWBBWWAWWUUUCCCCCCIQQCCCCIIIIRRRRRRRWWWGGVRRXXXXXXXXXXXXKKKKBBBBPPPPPPPPPPPPSSSVVVVVVVVVVVVVAFFFFFFFFFHHHBBBBBHHHRRRMMMMMMMKKKKKKKKVUUUUUUUU
    WWWAAAAWUUCCCCCCCIIICCCCCIIIIRRRRRRRWWGGVVVVXXXXXXXXXXXOBKBBBBBPPPPPPPPPPPPPPPPPLVVVVVVYVVVEFFFFFFHHHFFHHHHHBBBBHHHMMMMMMMMMKKKKKUUUUUUUUUUU
    WWWAAAAUUUUCCCCCCIIIIIIIIIIIURRRRRRRRRGGXXXXXXXXXXXXXXXRBBBBBBBBPQPPPPPPPPPUPPXEEVEVVVVVVVEFFFFFFFHHFFHHHHHHHHBHHMMMMMMMMMMMKKKKKKKKUUUUUUUU
    WWWAAAAUAUUCCCCCCLLIIIIIIIIUURRRRRRRRRGGXXXXXXXXXXXXXXXRRBBBBBBBPPPPPPPPPPPUPVEEEEEVVVVEVEEEEEFFFFHHHHHHHHHHHHHHHHMMMMMMMMMKKKKKKKKUUUUUUUUU
    WWAAAAAAAAUEEEOOOLIIIHIIIIIIURRRRRRRRRXXXXXXXXXXXRXXXXXXRBBBBBBBBPPPPBPPPBEBBBEEEEEVVVEEEEEEEEEEFHHHQHHHHHHHHHHHHHMMMMMMMMMMMKKKKKUUUUUUUUUU
    OOAAAAAAAAUOOOOOOLLLLIIIIIIIURRRRRRRRRXXLLLLXXXXXRXXXXXXRRMBBBBPBPPPPBBTPBBBBEEEEEEEEVEEEEEEEEEEFQQQQHHHHHHHHHMMMMMMMMMMMMMMMMMKKKKUUUUUUUUU
    OACCAAAAAGAOOOOOOELLLLIYIIRRRRRRRRRRRRXLLLLLXXXXXRRRRXXXRRRBBBBJKKPPPBBBBBBBBBEEEEEEEVEEEEEEEEEEEQQQQQHHHHHHHHHMMMMMMMMMMMMMMMMKKKUUUUUUUUUU
    AAAAAAAAAAAOOOOOEEELLLIYYVRRRRRRUUUUXXXLLLLLXXXXXRRRRXXXRMRBBBBJKJUBBBBBBBBBBBCEEEECEEEEEEEEEEEEQQQQQQHHHHHHHHHMMMMMMMMMMMMMMMWDDDWUUUUUUUUU
    AAAAAAAAAAAOOOOOUULLLYYYRRRRRRRRUUUUXXXXLLLLXXXXXXXXXXXXXMMCCBLJJJUBBBBBBBBBBQCCCCCCEEEEEEEEEEEEEFQQQHHHHHHHHMMMMMMMMMMMMMMMMWWWWWWWUUUUUUUU
    AAAAAAAAAAROOOOORRRRRRRRRRRYYDUUUUXXXXXXXLLLXXXXXXXXXXXXXCCCCCJJJJUUUUUBBBBCCCCCCCCCCEEEEEEEEEEEEEQQQEEHHHHHHHMMMMMMMMMDDDDDMWWWWWWUUUUUUUUU
    ZZAAAAAXAAROOOOORRRRRRRRRRRDDDUOUUAAXXXXWWLLLLRRXXXXXXXXXCCCCJJJJJJJJJJBBBLLLLLCCCCCEEEEEEEEEEEEEEEEEEEHEEEHHHMMMMMMMDDDDDDWWWWWWWWWWUWUUUUU
    ZZZAAAAOOOOOOOOORRRRRRRRRRRYDUUOUUUAXXXXXAAAALRRXXXXXXXXXCCCCCCCJJJJJLLLLLLLLLCCCCCCEEEEEEEESEEEEEEEEEEEEEHHHMMHMMMMDDDDDDDWWWWWWWWWWWWWWUUU
    ZZZAAAUOOOOOOOOORRRRQYYYYYYYYOUOUUAAAAAAAAAAALRRXXXXXXXXXCCCCCCJJJJJJLLLLLLLLLCCCCCCCCEEWWEEEEEEEEEEEEEEEEEHHHHHMHHHQQQQQQQQWQWWWWWWWWWWWWUU
    ZZAAXAUOOOOOOOOORRRREYYYYYOOOOOOOOAAAAAAAAAAAARAAAAAZXXXCCCCCCCJJJJJJJLLLLLLLLCCCCCCCCEEWWWEEEEIEEEEEEQQHHHHHHHHHHHQQQQQQQQQQQWWWWWWWWWWWWUU
    ZZAAXAUOOOOOOOOORRRROOYYREOOOOIOOOAAAAAAAAAAAARAAAAAZZZYYCCCCCCJCJJJJLLLLLLLLLCCCCCCCCCWWWEEEEIIEEEEEEEQQHHQHHHHHHQQQQQQQQQQQQWWWWWWWWWWWWUU
    ZZAAUUUOOOOOOOUUEEEEEEEEREOOOOIOOOAAAAAAAAAAAAAAAAAAZZZYYYYCCCCCCCCLLLLLLLLLLLLLCCCCPCWWWWEEEEIIIIEEEEEQQQQQHHAQQQQQQQQQQQQQQQWWWWWWWWWWWUUU
    PPPPPYUOOOOOOOEEEEEEEZEEEEOOOIIIIOAAAAAAAAAAAAAAAAAYYYYYYYYCCCCCCCCLLLLLLLLLLLLLCCCPPCWWWWWEEEIIIIEEEEQQQQQQQJJJJQQQQQQQQQQQQQQQQWWWWWWWUUUU
    PPPZYYYOOOOOOOOOOOEEEEEEEEIIIIIIIIAAAAAAQQAQAAAAAYAYYYYYYYYCCCCCCCLLLLLLLLJJLFLFFCTFFWWWWBBEEIIIIIKQQEQQQQQQJJJJJQQQQQQQQQQQQQQQQQWWWWWWUUUU
    PPPZYYYYYYYYYOOOOOEEEEEEEIIJIIIIIIACAAQQQQQQQAAYYYYYYYUYYYYCCCCCCCCLLLLLLLFFJFMFCCFFFSBBBBBBIIIIIIIQQQQQQQQQQQJJJJQQQQQQQQQQQQQQQQQWWKWWWUUU
    PPPYYCYYYYYYYOOOOOOEEEEEEIIIIIICCCCCCCCCCQQQQQYYYYYYYYYYYYYCYCCCCCCCLOOOLLFFFFFFFCFFFSSBBBBBIIBIIIBBQQQQQQQQQQQJJJQQQQQQQQQQQQQQQQQWLWWWWUUU
    PPYYYYYYYYYYYOOOOOOEEEEEEEIIIIICCCCCCCCCCQQQQQQQQYYYYYYYYYYYYCCCCCCOOOOOLHHFFFFFFFFFFFSSBBBBBBBIBBBQQQQQQQQQQQQQJJJQNQQQQQQQQQQQQQHHHHWWWWUU
    PYYYYYYYYYYYYOOOOOOEEEEEEEIICCCCCCCCCCCCCQQQQQQQQYYYYYYYYYYCCCICKITOOOOOHHHFFFFFFFFFFFFFBBBBBBBBBQQQQQQQQQQQQQJQJJJOQQQQOQQQQQQQQQQHHHHWWWHH
    PYYYYYYYYYYYYOOOOOOEEEEEIIIICCCCCCCCCCCCCQQQQQQQQYYYYYYYYZYSCCIIKIIOOOOOHHFFFFFFFFFFFFFFFFBBBBBBBBQQQQQQQQQQQQJJJJOOOQQQOQQQQQQQQQHHHHHHWWHH
    PYYYYYYYYYYYYOOOOOOEEIIIIIIICCCCCCCCCCCCCQQQQQQYYYYYYYYYYYYIIIIIIIIOOOOOHHFFFFFFFFFFFFFFFBBBBBBBBBQCQQQQQQQQXXXJJKKOOQQQQQQQQQQQQQHHHHHHHHHH
    PPPPYYYYYYYYYOOOOOOIEIIIIZZZCCCCCCCCCCCCCQQQQQQQPYYYYYYYYBYBIIIIIIIOOOOOIHHFFFFFFFFFFFFFFBBBBBBBBBBQQQQQQQQQXXXKKKKKKKKKKKQQQQQHHHHHHHHHHHHH
    PPPYYYYYYYYYYOOOOOOIIIIIIZZZCCCCCCCCCCCCCQQQQQQPPPYYYYYYYBBBIIIIIIIOOOJJIIFFFFFFFFFFFRFFFBBBBBBBBBBBQQQQQQQQXXXKKKKKKKKKKKQQQQQHHHHHHHHHHHHH
    PPPPPYYYYYYYYOOOOOOIIIIIIZZZCCCCCCCCCCCCCMQQQQQQQYYYYYYYYYYBBIIIIIIOOOOOOFFFFFFFFFFRRRFBBBBBBBBBBBBBBBQQQQQQQXKKKKKKKKKKKKQQQKQKHHHHHHHHHHHH
    PPPPPYYYYYYYYIIIIIIIIIIIIIZZCCCCCCCCCCCCCCCCCCCCCGGYYYYYBBBBIIIIEEIIOOOOODFFFFFFVBBRRRRBBBBBBBBBBBBBWBQQQQQQQQIIIKKKIKKKKKKKKKKKDDDDDDHHHHHH
    PPPPYYYYYYYYYIIIICIIIIIIIIIZCCCCCCCCCCCCCCCCCCCCCGGYYBBBBBBIIIEEEEEEOOOOOFFFFFFBBBBBRRBBBBBBBBBBBBBBWWWWQQQQPQIIIIIIIKKKKKKKKKKKKKDDDDHHHHHH
    PPPYYYYYYYYYYICIICCIIIIIIIZCCCCCCCCZZZCCCCCCCCCCCYYYYBBBBBBBIIEEEEEEOOOOOEEFFFFCBBBBRRBBBBBBBBBWWWWWWWWWQWWIIIIIIIIIPIKKKKKKKKKKKKDDDDDHHHHH
    PPPPYYYYYYYZYZCCCCIIIIIIIIZZCCCCCCCZZZCCCCCCCAQQAGLYBBBBBBBBBBEEEEEEOOOOOEEEFFWBBBBBBBBBBBBBBBBBWWWWWWWWWWIIIIIIIIIIIIIKKKKKKKKKKDDDDDDDDHHH
    PPPPYYJJYZZZZZCCCCIIIIIIIIIFZZZZZZZZZZCCCCCCCAAAAGGGGGGBBBBBBBEEEEEEOOOOOEEEEFWWBBBBBKKBKKBBBBBWWWWWWWWWWWWIIIIIIIIIIIKKKKKKKKKKKDDDDDDHHHHH
    PPZPPYJJYZZZZZZCCCCIIIIIFIIFFBFFZZZZAACCCCCCCAGAGGGGGGGGGBBBBEEEEEEEOOOOOEEEEWWHZZZBBWKKKKKBBWWWWWWWWWWAWWWWIIIIIFIIIIKKKKKKKPKKKDDDDNDHHHHH
    ZPPPPPZZZZZZZZZCCCCCCUIIFIIFFFFOOZZZAAACCCCCAAGGGGGGGGGGBBBBBEEEEEEEOOOOOEEEXHHHZWWWWWKWWKKWWWWWWWWWWWAAAWWWIIIIIFFIKKKFFFKPKPKKKKDDDDHHHHHH
    ZZZPZZZZZZZZZZZCIIRCUUUIFFFFFFFOFBZAAAACCCCCAAGGGGGGGGGGGGBEEEBEEEEEDEDDEEEEXHHHHHHWWWWWKKKKWWWWWWWWWWAAARRWIIIIFFFIFKFFFFPPPPKKKKKPHHHHHHHH
    ZZZZZZZZZZZZZZZIIIIIUUUFFFFFFFFFFZZZNANCCCCCAGGGGGGGGGGGGGBBBBBEEDDDDDDDDEEEEEHHHHHWWWWWWKWWWGWWWWWWWWAAARRRIIIIFFFFFFFFFFFPPPKPKKKPPPHHHHHH
    ZZZZZFZZZZZSSZZRIIIIUUUFFFFFFFFFFFFFNNNCCCCCGGGGGGGGGGGGGBBBBBBBDDDDDDDDDDEEEEHHHHWWWWWWWWWWWWWWWWWWAAAAARRRIIIIIFFGFFFFFFFFPPPPKPPPPPPHHHHH
    FFFFFFZZZZZZSSSIIIIIUUUUUUUFFFFFFFWNNNNNNANGGGGGGGGGGGGGBBBBBBBBDDDDDDDDDDDDEHHHHHWWWWWWWWWWWWWWWWWWAAARRRRRIRIIFFFFFFFFFFFWPPPPPPPPPPPHHHHH
    GFFFFFLZZZXZSSSSSSSIUUUUUUUFFFFFFFFFNNNNNNNNNGGGGGGGGGBBBBBBBDBDDDDDDDDDDDDDHHHHHHWWWWWWWWWWWWJJJWAAAARRRRRRRRRIFFFFFFFFFFFWWPPPPPPPPPPPHHHH
    GFFFFFFFFZFQFSSSSSSUUUUUUUUUFFFFFLFYNNNNNNNNGGGGGGGGGGBBBBBBBDBDDDDDDDDDDDDDHHHHHHHWWWWWWWWWWWWWJAAAARRRRRRRRRRQFFFFFFFFFFFFWPPWWPPPPPPPHHHH
    GGFFFFFFFFFFFSSSSSSUUUUUUUUUUFFFZNNNNNNNNNNNUUUGGGGGHIIBBBBBDDDDDDDDDDDDDDDDHHHHHHHWWWWWWWWWWWWUAAAAAAIRRRRRRRQQFFQRFFFFFFFFWWWWWPPPPPPUIISS
    FFFFFFFFFFFFIFSSIIIIUUUUUUUUFFFFINNNNNNNNNNNNNUGGGGIIIIIIIIIDDDDDDDDDDDDDDDHHHHHHHHWWWWWWWWWWWWWCACCCQQQRRRQQQQQQFFRCFFRRFFWWWWWWPPPPPPUUIIS
    QQQFFFFFFFFFIFIIIIIIUIUUUUUUUIIIIIINNNNNNNNBNNUUGGGIIIIIIIIIDDDDDDDDDDDDDOEHEHHHHHHWWWWWWWWWWSWCCAACQQQQQQQQQQQQQQQRRRRRRRRWWWWWWPPPPPPPPIIS
    QQQQFQFFFFFFFFPIIIIIIIUUUUIIIIIIIIINNNNNNNNNNUUUUUIIIIIIIIIIAADDLDDDDDDDDOEEEHHHHHWWWWWWWWWWHHCCCCCCQQQQQQQQQQTTQQRRRRRRRRRWWWWPPPPPPPPPIIIS
    KQQQQQFFFFFFFFFIIIIIIIUUUUIIIIIIIIINNNNNNNNNNUUUUUUIIIIIIIIIADDDLDDDDXXEEEEEEHHHHHHHWWRQQQHHHHCCCCCQQQQQQQQQQTTTTTRRRRRRRRRRPPPPWPPPPPPIIIII
    KKKQSSSSFFFFFFFIIIIIIIUIIIIIIIIVIIIVVVNNNNNNNNUNUUUIIIIIIIIDDDDDLDXDDXXEEEEEEEHHHHHHWRRQQQHHHHCCCCCQQQQQQQQQQTTTTRRRRRRRRRSSSPPPPPPPPIIIIIII
    SKVSSKSSALLLNLLRIIIIIIIIIIIIIIIVVVVVNNNNNNNNNNNNUUUIIIIIWWDDDDDDDDXXXXXEEEEEEEEHHHHHHRRQQQHHHHHHHCCCQQQQQQQQQTTTTRYRRRRRRRSSSSSSPPPPPIIIIIII
    SSSSSSSSLLLLLLLRIIIIIIIIIIIIIIIVVVVVVVNVNNNNNNNUUUUIIIIIDDDDDDDDDDDXDXXEEEEEEEESAHHHHRRQQQQQHHHHHHHHHHHQQQQQQTTTTYYYRRRRRRSSSLLLPPPIIIIIIIIW
    SSSSSSSSLLLLLLLLIIIIIIIIIIIIIVVVVVVVVVVVNNNNNNNNNUUIIILDDDDDDDDDDDDDDDDEEEEEESSSSQQIFFFFFFFFUHZHHHHHNNHQQTQTTTTTTYYYYRRVLLLLLLLLBIIIIIIIIIIW
    WWWSSSSSLLLLLLLLINNIIIIIIIIIVYVVVVVVVVVVNNNNNNNNUUUUUUUBBDVDDGDDDDDEEEDEEEEESSSSSQQQFFFFFFFFQZZZZHHHHNNNTTTTTTTTYYYYYRRLLLLLLLLLBBIIIIIIIIIW
    WWSSSSSSSSLLLLLNISNIIIIIIIIIVVVVVVVVVVVVVNNANNNNNUUUUUULLMLDDGGDDDDEEEEEESSSSSSSQQQQFFFFFFFFQQZZHHHNNNNTTTTTTTTHHYSYYYYLLLLLLLLLBIIIIIIIIIII
    WWWSSSSSSSSSSSNNNNNNIIIIIVVVVVVVVVVVVVVVAAAANNNNNUUUUUUULLLDDDLLDDDDEEEEESSSSSSSSSQQFFFFFFFFFFFZZZHNNNNTTTTTTTTHYYYYYYYLLLLLLLLLBIIIIIIIIIIX
    WWWSSSSSSSSSSSNNNNNIIIIIIVVVVVVVVVVVVVVVAAANNNNTTTUUUUULLLLLLLLNDDDDMEESSSSSSSSSSQQQFFFFFFFFFFFZJJJJNNNNNTTTTFFFFYYYYYYLLLLLLLLLLLBIXIIIIIXX
    WZWZSSSSSSSSSSNNNNNNIIIIIVIVVVVVVVVVVVVVAAAAANNTUUUULLLLLLLLLLLLQDLDEEESSSSSSSSSSQQQFFFFFFFFFFFJJJJNNNFFNTTTTFFFFKKYYYYRLLLLLLLLTTTIIHHIIMMX
    ZZZZSSSSSSSSNNNNNNNNIIIIIIIIVVVVVVVVVVVVAAAAETTTQUUUULLLLLLLLLLLLWLLEEESSSSSSSSSSQQQFFFFFFFFFFFJJJJJJJFFFFFFFFFFKKKYYYRRRLLLLLTTTTTHHHHIMMMM
    ZZZZSSSSSCCCNNNNNNNNNIIIIIIIVIVVVVVVVVAAAAAEETTTQQUUULLLLLLLLLLLLLLLEESSSSSSSSSSSQSQFFFFFFFFFFFFFFFJJWFFFFFFFFFFKKKKYRRRRRLLLLTSTTTTHHHHMMMM
    ZZZZSSSCCCCCYNNNNNNNNIIIIIIIIIVVVVVVAAAAAEEEETTQQQUUULLLLLLLLLLLLLLLEEQSSSSSSSSSSSSQFFFFFFFFFFFFFFFJJFFFFFFFFFFKKKKKKRRRRRLLLLTTTUTTTHMMMMMM
    ZZKKCCCCCCCCCCNNNNNNIIIIIIIIIIIIRVVVVAAAAAEEEEEEEQUQLLQLLLLSSSSLLQQLQQQSSSSSSSSSSSSCFFFFFFFFFFFFFFFTJTFFFFFFFFPFKKKKKKRRRLLLLLLLTUTTTHHMMMMM
    KKKKCCCCCCCCCCNNNNNNIIIIIIIIIIIIIIAAAAAEEEEEEEEEEQQQQQQLLLLLESSSSQQLQQQSSSSSSSSSSSSSFFFFFFFFFFFFFFFTTTTFFFFFFFFFFKKKRRRRRRLLLLLLTTTTTTHHMMMM
    UKKKCCCCCCCCCNNRYYIIIIIIIIIIIIIIIIAAAAAEOEEEEEEEEEQQQLLLLLLLESSSQQQQQQQQSSSVSSSSSSSJFFFFFFFFFFFFFFFTTFFFFFFFFFFFKKKKKRRRRRLLLLLLLLTTTTHHMMMM
    UKKCCCCCCCCCCCNCYYIIIIIIIIIIIIIIIIAABAAAEEEEEEEEEQQQQQLLLLLLEEQQQQQQQQQQSSVVSSSSSSSSFFFFFFFFFFFFNNNNTNNFFFFFFZKKKKKKKRRRRLLLLLLLLLTTTTHHMMMM
    UKKCCCCCCCCCCCCCYYIIIIYYYYYIIIIIAAABBBBEEEEEEEEEQQQQSSLLLESSEQKQQQQQQQQQSVVVVSSSSPPSFFFFFFFFFFFFNNNNANNNFFFFFFKKKKKKKIIRILBULLLLLLTTMMMMMMMM
    UKKKCCCCCCCCCCYYYYYIIIYHYYYYYYIAAAABBBBBEEEEEEQQQQQQSSSSSSSSEQQQQQQQQQQQQQVVQPPPPPSSSYFFFFFFFFFFNNNNNNNNNNFFFFKKKKKKKIIIIIUUUULUTTTTTTMMMMMM
    UUKKKCCCCCCCCYYYYYYIYIIHHHYAAAIAAAABBBBBBEEEEEEESSSSSSSSLLSSQQQQQQQQQQQQQQQQQPPPPPSYYYYJFFFFFFFFNNNNNNNGNMMMFFKKKKKKIIIIIIUUUUUUUTTTTMMMMMMM
    UKKCCCCPCCCSSYYYYYYYYYYHHFAACAAAAAAABBBBBEEEDDSSSSSSSSSSLSSSHVQQQQQQQQQQQQQQQQQPPPYYYYEEEEEJJJJNENENNNNNNMMMMFKKKKKKIIIIUUUUUUUUUTUTMMMMGMMM
    UKKKKKCCCCCYYYYYYYYYYYYHHHAAAAAAABBBBBBBBEEBSSSSSSSSSSSSSSSHHVQQQQQQQQQQQQQQQQQPPPYYYYYEEEEEEEEEENENNNNNNMMMMMKKKKKKIEEIIUUUUUUUUUUUDMMMGMMZ
    UKKKKKKKCCCAAAYYYYYYYYYHHHTAAAAAAAABBBBBBBBBBBBSSSSSSSSSSSSVVVQQQQQQQQQQQQQQQXXPPYYYYYYHEEEEEMEEEEEENNNNNMMMMKKKKKIIIEEEEUUUUUUUUUUUMMMMMMMZ
    KKKKKKKKTTCCCYYYYYYYYYHHHAAAAAAAAAJJBBBBBBBBBBBBSSSSSSSSSSSSVVQQQQQQQQQQQMQDQXXPYYYYYYEEEEEEEEEEEEEENNNNMMMMMMMMKKEIEEEEEEEPUUUUUMMMMMMMMZZZ
    KKKKKKKTTTMMKBYYYYYYYYHHHHHAAAAAAAJJBBBBBBBBBBSSSSSSSSSSSSSVVVVVQQQWQQQQMMXDQXXPYYYYYYYYEEEEEEEEEEEENNMMMMMMMMMKKKEEEEEEEEEEUUZUIMMMMMMMMZZZ
    KKKKKKTTTTTMKKYYYYHHHHHHHHHUAAAAAAJJBBBBBWWBBSSSSSSSSSSSSSVVVVVVQTQWQMMMMMXXQXXXXYYYYYEEEEEEEEEEEEEENNNNMMMMMMMKRKEEEEEEEEEEUZZZMMMMZMMMZZZZ
    KKTTTTTTTTTTKKYYKKKKKHBHHHHZLAAAAAAJJBBBNWWWRWWSSSSSSSSVVVVVVVVVVVVVQMMMMXXXXXXXPXXYYYYYEEEEEEEEEEENNNNNMWMMMMSSRRREEEEEEEEZZZZZZMMMZMMMMZZZ
    KKTTTTTTTTTTKKKKKTKKKHBHHNZZLLLAAAJJJJBJWWIWWWWWSSSSSSSVVVVVVVVVVVVMMMMMMXXXXXXXXXXXYYYYEEEEEEEEEEEEEWWWMWWMMMSSRSSSEEEEEEEEZZZZZZMZZZMZZZZZ
    TTTTTTTTTTTTJTTTTTTKKKKHHHZZZZLAAAAAAJJJJWWWWMMMMSSSSSVVVVVVVVVVVVVMMMMXXXXXXXXXXXXXYYYYYYEEEEEEEOWWNWWWWWWWWMSSSSSQESEEEEEEZZZZZZZZZZZZZZII
    TTTTTTTTTTTTTTTTTTTKKKKKHHZZZAAAAAAJJJJJWWWWWMMMMSSSSSSVVVVVVVVVVVVVMMMMXXXXXXXXXXXXYYYYYIIIIEIHEOWWWWWWWWWMMMSSSSSSSSSEEEEEYYZZZZZZZZZZZIII
    TTTTTTTTTTTTLTTTTTTKKKKKKKKKAAAAAAAAAJJJJJWWWMMMMSSSSSSSVVVVVVVVVVVVVMMXXXXXXXXXXXXXXYYYIIIIIIIWWWWWWWWWWWWMMMSSSSSSSSSEEEDEYYYYZZZIIIIIZIII
    TTTTTTTTTTTTTTTTTTTKKKKKKKKAAAAAAAAAJJJJWWWWWMMMMSSSVSSVVVVVVVNVVNNNVMMXXXXXXXXXCXYXXYYIIIIIIIIIWWWWWWWWWWWWMMMSSSSSSSSEEYDYYZZZZZIIIIIIIIII
    TTTTTTTTTTTTTTTTTTTTTKKKKKKAAAAAAAAAWWWWWWWWWMMMMCVVVVVVVVVVVNNNNNNNXNNXXXXXXXXXYYYYYYYIIIIIIIIIGWWWWWWWWWWWMMSSSSSSSSSYYYYYYKKZZIIIIIIIIIII
    TTTTTTTTTTTTTTTTTTTTTKKKKKKKKAAAAAAAWWWWWWWWWMMMMCVVVTVVVVVVVNNNNNNNNNNKKXXXXXXXYYYYYYIIIIIIIIIIWWWWWWWWWWWWSSSSSSSSSSSZZYYYYYYZJIIIIIIIIIII
    TTTTTTTTJTTTTTTTTTTTTTYKKKKKKAAAAAAAWWWWWWWWWMMMMWVVVTVVVNVVNNNNNNNNNNNNKXXXXXYYYYYYYYYYIIIIIIIIWWWWWWWWWWWWSSBSSSSSSZSZZZYZYYZZIIIIIIIIIIII
    ZTZTTTTTTTTYYTTTTTTTAAYKKKKKKAAAAAAWWWWWWWWWWMMMMMMMMMMMMMVVNNNNNNNNNNKKKXXXKKYYYYYYYYYIIIIIIIIIIIWWWWWWWWWWSASSSSQSZZZZZZYZYZZZZIIIIIIIIIII
    ZTZTTTAYYYYYYTTTTTTTTYYYYTTAAAAAAAAWWWWWWWWWWMMMMMMMMMMMMMNNNNNNNNNNNNNKKKKKKKKYYYYYYYYKIIIIIIIIIIWWWWWWWWNWAASSSSSSZZZZZZYZZZZZZIIIIDIIIIII
    ZZZZTHAAAYYAYYTTTTTTTTYYYYYUUAAAAAAUWWWWWWWWWMMMMMMMMMMMMMNNNNNNNNNNNNNKKKKKKKKYYYYYYYKKKIIIIIIIIIWWWWWGNNNNNNSQSSZZZZZZZZZZZZZZZZIIDDIIIIII
    ZZZZZZAAAAYAYYYYTTTTTTYYUUUUUUAUUUUUWWWWWWWWWMMMMMMMMMMMMMNNCNNNNNNNNKKKKKIIIKIIIYYYYYYYKIIIIIIIIWWWWWWWNNNNNNPPSSPPZZZZZZZZZZZZZZZDDDIIIIII
    ZZZZZAAAAAAAAAYTTTTTYYYYYUUUUUAUUUDUWWWWWDWWWMMMMMMMMMMMMMNNNNNNNNNNNKKKKIIIIIIIIIRYYYYKKIIIIIIIINWUWIWNNNNNNNNPPPPPZZZZZZZZZZZZZZDDDDDIIIII
    ZZZZZAAAAAAAAAAANTTTTYYYYYUUUUUUUDNNNNDDDDWWDMMMMMMMMMMMMMTTNNNNNNNNNKKKKIIIIIIIIIIIYYKKKKIIIIIINNNNIIIINNNNNNPPPPPPPPZZZZZZZZZZZZDDDDDDIIII
    ZZZZZAAAAAAAAAAAAJJTTYYYYUUUUUUUAAAAAAAAADDDDMMMMMMMMMMMMMTTNXXXNNNNRKKKKKIIIIIIIIIIJYYKKKKIIIINNNNNXXXIINNJJNPPPPPPPZZZZZZZZZZZZDDDDDDDDIII
    ZZZZZAAAAAAAAAAAAYYYYYYYYUYYUUUUAAAAAAAAAAADDMMMMMTTTTTTTTTMMXXXXNNNRRKKRROIIIIIIIBBYYYKGKIIIINNNNNNXXXXNNJJJNPPPPPPPZZZZZZZZZZZDDDDDDDDDDII
    ZZZZZAAAAAAAAAAAAAYYYYYYYYYYUUULAAAAAAAAAAADRMMMMMMTTXXTXTTTPPXVVNNNRRRKRIIIIIIIIIBGGGGGGKIIIBNNNNNXXXXXXNNJXNPPPPPPPPPPPPSSZSSZSDDDDDDDDDII
    ZZZZZAAAAAAAAAAAAAAAYYYYYYYLLLLLUDNNNNNAAAADURRRRMMTTTXXXTMTBPPPPPRRRRRRRRIIIIIIIIBGGGGGKKKIIBBNNNXXXXXXXXXXXPPPPPPPPPPPSYSSSSSSSUDSDSDDIIII
    ZZZZAAAAAAAAAAAAAAAAYYYYYYYYLLLLLDNNNNNAAAADURRRRRMTTXXXTTTPPPPPPPVRRRRRRRRLIIIIIIIGGGGGKKNYIBBNNNNEXXXXXXXXXPPPPPPPPPPSSSSSSSSSSUDSSSIIIIII
    ZZZZZAAAAAAAAAAAAAAXYYYYYYYYYLNNNNNNNNNAAAARRRRRRRRRXXXXXTTPPPPPPRRRRRRRRRRLLIIIIIIGGGGKKNNYNNNLNNNXXXXXXXXXXPPPPPPPPPPPPSSSSSSZZZZZIIIIIIII
    ZZZZZAAAAAAAAAABBBAXYYYYYYYYLLNNNNNNNNNAAAAAAARRRRRRRXXXXPPPPPPPPRRRRRRRRRRLLIIIINIGGGSKSXNNNNNNNKKXXXXXXXXXXPPPPPPPPPPPKSSSSSSZZZZZZIIIIIII
    ZZZZZZZZEAAAABBBBYYYYYYYYYYLLLNNNNNNNNNAAAAAAARRRRRXXXXXXXPPPPPPPRRRRRLMRRLLLLLIINNGGSSSSSNNNNNNKKKXXXXXXXXXXPPPPPPPPPPSKSSSSSSZZZHHHLIIZIIU
    ZZZZZZZZEEEEAABBYYYYYYYYYLLLLLNNNNNNNNNAAAAAAARRRRRXXXXXXXXPPPPPPRRRRRLLLLLLLLLLLLLLLLSSSANNNNNNNKKXXXXXXXXXPPPPPPPPPPPSSSSSSSSZZHHHHHHIHHIH
    ZZZZZZZEEEEEEBBBYYYYYYYYYLLYRLNNNNNNNNJAAAAAAARRXXRXXXXXXXXXPPPPPRRRRRRRLLLLLLLLLLLLOSSSSANNNNKKKKKKKKXXXXXPPPQQPPPPPIISSSISSSSSZHHHHHHHHHHH
    ZZZZZZEEEEEEGGBBYYYYYYYYYYYYRRNNNNNNAAAAAAAAAAXXXXXXXXXXXXXXXXPPPPRRRRRRRLLLLLLLLLLLLRRNNNNNNNNKKKKKKXXXXKKPPPQQQPPPPIIIIWISSBSSSSSHHHHHHHHH
    ZZZZZZEEEEEEGYYYYYYYYYYYYYYYRRNNNNNNAAAAAAAJRXXXXXXXXXXXXXXXXXPPPRRRRRLRRLLLLLLLLLLLLLLKNNNNNNNNKKKKKKKKXKPPPQQQQQQQPIIIIIIIIBSSSHHHHHHHHHHH
    ZZZEEEIEEEGGGGGYYYYYYYYYYYYYRYYRRJJJAAAAAAAWXXXXXXXXXXXXXXXXXXXPPRRRRRLLRLLLLLLLLLLLLLKKNNNNNNNNKKKKKKKKKKKQQLQQQQQQPIIIIIIIIBBBSHHHHHHHHHHH
    ZZZZZEEEEEGGGGGYYYYYYYKKKKYYYYYRRRJJAAAAAAAAAAXXXXXXXXXXXXXXXXJPRRRRROOLLLLLLLLLLLLLKKKKKNNSNNKKKKKKKKKKKEEQQQQQQQQQQIIIIIIIIIIIIHHHHHHHHHHH
    ZZZZZEEEEEZZGGGGYGYYYYKKKKKKKKRRRRJJAAAAAAAAAAQNNXXXXXXXXXXXBXJPBRRROOOOOQQQQLLLLLLKKKKKKNNNNNKKKKKKKEEEKEEEQQQQQQQQQIIIIIIIIIIIIIIHHHHHHHHH
    ZZZZZZZEZZZZZZGGGGGGGYKKKKKKKRRRRJJJJJJJAAAAAAQNNXXXXXXXXXXXBBBBBBBOOOOOOOOQLLLLLLQKKKKKKKKKKKKKKKKKKKEEEEEEQEQQQQQIIIIIIIIIIIIIIIHHHHHHHHHH
    ZNZZZZZZZZZZZZZGGGGGGKKNKKKKKKRRRRJNNNNNAAAAAANNNNXXXXXXXBXBBBBBBBAOOOOOOOOQLLLLLQQQKKKKKKKKBKKKKBKKKEEEEEEEEEEQQQQIIIIIIIIIIIIIIIHHHHHHHHHH
    NNZZZZZZZZZZZZZZGGGGKKKKKKKKKKKKNNNNNNNNAAAAAANNNNSSSSSBXBBBBBBBBBOOOOOOOQQQQQLLQQQQQKKBKKKBBBBBBBBKEEEEEEEEEEEQQQQIIIIIIIIIIIIIDIHHHHHHHHHH
    NNNNZZZZZZZZZZZZGGGGKKKKKKKKKKKNNNNNNNNNNNNNNNNNNNSSSSBBBBBBBBBBBBOOOOOOOQQQQQQQQQQQQKKBKKKBBBBBBBBBMEEEEEEEEEEQQQQIIIIIIIIIIIIIDHHHHHHHHHHQ
    NNNNZZZZZZZZZGGGGGGGKKKKKKKKKKKNNNNNNNNNNNNNNNNNNNSSSSBBBBBBBBBBBBIOOOOOOOQQQQQQQQQQKKKBBBBBBBBBBLBEEEEEEEEEEEEQQQQIIIIIIIIIIIIIDHHHHHHHHHHH
    NNNNNNNNZZZZZGGGGGKKKKKKKKKKKKKNNNNNNNNNNNNNNNNNNXSSSSBBBBBBBBBBBBIOOOOOOOOOQQQQQQQQQBBBBBBBBBBBBEEEEEEEEEEDEQQQPQQFSSIIIIIIISIIDDHHHHEHHHDD
    NNNNNNNNNZZZGGGGGGGKGKQKKKKKKKXNNNNNNNNNNNNNNNRNSXSSSBBBBBBBBBBBBBIIIIIOOOLQQQQQQQQQOBBBBBBBBBBBBEEEEEEEEEEDEFQQPQFFSSIIIIIISSSSDDDHHEHHHHDD
    NNNNNNNNNZNNGGGGGGGGGKKKKKKKKXXNNNNNNNNNNNNNNNSSSXXSSSBBSBBBBBBBBBBBBIIOOOQQQQQQQQQQQBBBBBBBBBBBBBEEEEEEDDDDFFQQQFFFSSSSSSSIISSSSSDDDHHHDHDD
    QNNNNNNNNNNGGGGGGGGGGKGGKKKKKKXXNNNNNNNNNNNNSSSSSXSZSSZBBBBBBBBBBBBBBIIIOIQQQQQQQQQQKBBBBBBBBBBBBBBDDEEDDDDDFQQFFFSSSSSSSSSSSSSSSSDDDDDDDDDD
    NNNNNNNNNNNNNGGGGGGGGGGGKKIKKXXXXNNNNNNNSNSSSSSSSSSZSZZZZZBBBBBBBBBBBBIIOIIIQQQQQQABBBBBBBBBBBBBBBBBDDEEDDDFFFFFFFSFSSSSSSSSSSSSSDDDDDDDDDDD
    NNNNNNNNNPNGGGGGGGGGGGGGGKKXXXXXXNNNNSSSSSSSSSSSSSSZZZZZZZBBBBBBBBBBBIIIIIQQQQQQQQQBBBBBBBBBBBBBBBDDDDDDDDDFFFFFFFFFSSSSSSSSSSSSDDDDDDDDDDDD
    """
  end

  def test_input do
    """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """
    |> String.trim()
  end
end
