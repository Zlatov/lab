namespace :test_task do

  desc "TODO"
  task task1: :environment do
    require 'json'
    array = [
      {
        'id' => 1,
        'parent_id' => nil,
        'header' => 'H1',
      },
      {
        'id' => 2,
        'parent_id' => 1,
        'header' => 'H2',
      },
      {
        'id' => 3,
        'parent_id' => nil,
        'header' => 'H3',
      },
      {
        'id' => 4,
        'parent_id' => 1,
        'header' => 'H4',
      },
      {
        'id' => 5,
        'parent_id' => 2,
        'header' => 'H5',
      },
      {
        'id' => 6,
        'parent_id' => 3,
        'header' => 'H6',
      },
      {
        'id' => 7,
        'parent_id' => 4,
        'header' => 'H7',
      },
      {
        'id' => 8,
        'parent_id' => 5,
        'header' => 'H8',
      },
      {
        'id' => 9,
        'parent_id' => 7,
        'header' => 'H9',
      },
    ]
    array.shuffle!
    json = array.to_json

    p "json:"
    p json
    puts

    hash = JSON.parse json

    p "hash form json:"
    p hash
    puts

    hash = to_multidimensional({
      :hash => hash,
      :root_id => nil,
      :fields => ['id','parent_id','children','header'],
      :add_level => true
    })

    p "multidimensional hash:"
    p hash
    puts

    string = multidimensional_to_s(
      :hash => hash,
      :fields => ['id','parent_id','children','header'],
    )
    p string



    # function convertIntoMultidimensionalArray($array, $idOfTheRoot, $fields, $addLevel = false, $forAlternativeJson = false)
    # {
    #     $return = [];
    #     $cache = [];
    #     // Для каждого элемента
    #     foreach ($array as $key => $value) {
    #         // Если нет родителя элемента, и элемент не корневой,
    #         // тогда создаем родителя в возврат а ссылку в кэш
    #         if (!isset($cache[$value[$fields[1]]]) && ($value[$fields[1]] != $idOfTheRoot)) {
    #             $arrayIntoReturn = [];
    #             foreach ($fields as $fieldKey => $fieldName) {
    #                 switch (true) {
    #                     case $fieldKey === 0:
    #                         $arrayIntoReturn[$fieldName] = $value[$fields[1]];
    #                         break;
    #                     case $fieldKey === 1:
    #                         $arrayIntoReturn[$fieldName] = null;
    #                         break;
    #                     case $fieldKey === 2:
    #                         $arrayIntoReturn[$fieldName] = [];
    #                         break;
    #                     default:
    #                         $arrayIntoReturn[$fieldName] = null;
    #                         break;
    #                 }
    #             }
    #             $return[$value[$fields[1]]] = $arrayIntoReturn;
    #             $cache[$value[$fields[1]]] = &$return[$value[$fields[1]]];
    #         }
    #         // Если элемент уже был создан, значит он был чьим-то родителем, тогда
    #         // обновим в нем информацию о его родителе
    #         if (isset($cache[$value[$fields[0]]])) {
    #             $cache[$value[$fields[0]]][$fields[1]] = $value[$fields[1]];
    #             foreach ($fields as $fieldKey => $fieldName) {
    #                 switch (true) {
    #                     case $fieldKey === 0:
    #                         break;
    #                     case $fieldKey === 1:
    #                         $cache[$value[$fields[0]]][$fieldName] = $value[$fieldName];
    #                         break;
    #                     case $fieldKey === 2:
    #                         break;
    #                     default:
    #                         $cache[$value[$fields[0]]][$fieldName] = $value[$fieldName];
    #                         // $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                         break;
    #                 }
    #             }
    #             // Если этот элемент не корневой,
    #             // тогда переместим его в родителя, и обновим ссылку в кэш
    #             if ($value[$fields[1]] != $idOfTheRoot) {
    #                 $cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]] = $return[$value[$fields[0]]];
    #                 unset($return[$value[$fields[0]]]);
    #                 $cache[$value[$fields[0]]] = &$cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]];
    #             }
    #         }
    #         // Иначе, элемент новый, родитель уже создан, добавим в родителя
    #         else {
    #             // Если элемент не корневой - вставляем в родителя беря его из кэш
    #             if ($value[$fields[1]] != $idOfTheRoot) {
    #                 $arrayIntoReturn = [];
    #                 foreach ($fields as $fieldKey => $fieldName) {
    #                     switch (true) {
    #                         case $fieldKey === 0:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                         case $fieldKey === 1:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                         case $fieldKey === 2:
    #                             $arrayIntoReturn[$fieldName] = [];
    #                             break;
    #                         default:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                     }
    #                 }
    #                 // Берем родителя из кэш и вставляем в "детей"
    #                 $cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]] = $arrayIntoReturn;
    #                 // Вставляем в кэш ссылку на элемент
    #                 $cache[$value[$fields[0]]] = &$cache[$value[$fields[1]]][$fields[2]][$value[$fields[0]]];
    #             }
    #             // Если элемент кокренвой, вставляем сразу в return
    #             else {
    #                 $arrayIntoReturn = [];
    #                 foreach ($fields as $fieldKey => $fieldName) {
    #                     switch (true) {
    #                         case $fieldKey === 0:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                         case $fieldKey === 1:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                         case $fieldKey === 2:
    #                             $arrayIntoReturn[$fieldName] = [];
    #                             break;
    #                         default:
    #                             $arrayIntoReturn[$fieldName] = $value[$fieldName];
    #                             break;
    #                     }
    #                 }
    #                 $return[$value[$fields[0]]] = $arrayIntoReturn;
    #                 // Вставляем в кэш ссылку на элемент
    #                 $cache[$value[$fields[0]]] = &$return[$value[$fields[0]]];
    #             }
    #         }
    #     }
    #     if ( $addLevel ) {
    #         $level = 1;
    #         $parentArray[$level] = $return;
    #         while ($level >= 1) {
    #             $mode = each($parentArray[$level]);
    #             if ($mode !== false) {
    #                 $parentArray[$level][$mode[0]]['level'] = $level;
    #                 if (count($mode[1][$fields[2]])) {
    #                     $level++;
    #                     $parentArray[$level] = $mode[1][$fields[2]];
    #                 }
    #             } else {
    #                 $level--;
    #             }
    #         }
    #     }
    #     if ( $forAlternativeJson ) {
    #         reset($return);
    #         $alternativeArray = [];
    #         $level = 1;
    #         $parentAlternativeArray[$level] = &$alternativeArray;
    #         $parentArray[$level] = $return;
    #         while ($level >= 1) {
    #             $mode = each($parentArray[$level]);
    #             if ($mode !== false) {
    #                 $tempArray = [];
    #                 foreach ($fields as $fieldKey => $fieldName) {
    #                     switch (true) {
    #                         case $fieldKey === 2:
    #                             $tempArray[$fieldName] = [];
    #                             break;
    #                         default:
    #                             $tempArray[$fieldName] = $mode[1][$fieldName];
    #                             break;
    #                     }
    #                 }
    #                 $parentAlternativeArray[$level][] = $tempArray;
    #                 if (count($mode[1][$fields[2]])) {
    #                     end($parentAlternativeArray[$level]);
    #                     $key = key($parentAlternativeArray[$level]);
    #                     $level++;
    #                     $parentArray[$level] = $mode[1][$fields[2]];
    #                     $parentAlternativeArray[$level] = &$parentAlternativeArray[$level-1][$key][$fields[2]];
    #                 }
    #             } else {
    #                 $level--;
    #             }
    #         }
    #         $return = $alternativeArray;
    #     }
    #     return $return;
    # }

    # function multidimensionalArrayToString($array = [], $fields)
    # {
    #     $return = '';
    #     if (!count($array)) {
    #         return $return;
    #     }
    #     $level = 1;
    #     $parentArray[$level] = $array;
    #     while ($level >= 1) {
    #         $mode = each($parentArray[$level]);
    #         if ($mode !== false) {
    #             $return .= str_repeat("\t", $level-1) . $mode[1][$fields[0]] . PHP_EOL;
    #             if (count($mode[1][$fields[2]])) {
    #                 $level++;
    #                 $parentArray[$level] = $mode[1][$fields[2]];
    #             }
    #         } else {
    #             $level--;
    #         }
    #     }
    #     return $return;
    # }

  end

  private
    def to_multidimensional params
      ret = {}
      cache = {}
      params[:hash].each do |value|
        # Если нет родителя элемента, и элемент не корневой,
        # тогда создаем родителя в возврат а ссылку в кэш
        if !(cache.key? value[params[:fields][1]]) && (value[params[:fields][1]] != params[:root_id])
          temp = {}
          params[:fields].each_with_index do |field, index|
            case index
              when 0
                temp[field] = value[params[:fields][1]]
              when 1
                temp[field] = nil
              when 2
                temp[field] = {}
              else
                temp[field] = nil
              end
          end
          ret[value[params[:fields][1]]] = temp;
          cache[value[params[:fields][1]]] = ret[value[params[:fields][1]]];
        end
        # Если элемент уже был создан, значит он был чьим-то родителем, тогда
        # обновим в нем информацию
        if cache.key? value[params[:fields][0]]
          # $cache[$value[$fields[0]]][$fields[1]] = $value[$fields[1]];
          params[:fields].each_with_index do |field, index|
            case index
              when 0
              when 1
                cache[value[params[:fields][0]]][field] = value[field]
              when 2
              else
                cache[value[params[:fields][0]]][field] = value[field]
              end
          end
          # Если этот элемент не корневой,
          # тогда переместим его в родителя, и обновим ссылку в кэш
          if value[params[:fields][1]] != params[:root_id]
            cache[value[params[:fields][1]]][params[:fields][2]][value[params[:fields][0]]] = ret[value[params[:fields][0]]]
            ret.except! value[params[:fields][0]]
            cache[value[params[:fields][0]]] = cache[value[params[:fields][1]]][params[:fields][2]][value[params[:fields][0]]]
          end
        # Иначе, элемент новый, родитель уже создан, добавим в родителя
        else
              # Если элемент не корневой - вставляем в родителя беря его из кэш
              if value[params[:fields][1]] != params[:root_id]
                  temp = {}
                  params[:fields].each_with_index do |field, index|
                    case index
                      when 0
                        temp[field] = value[field]
                      when 1
                        temp[field] = value[field]
                      when 2
                        temp[field] = {}
                      else
                        temp[field] = value[field]
                      end
                  end
                  # Берем родителя из кэш и вставляем в "детей"
                  cache[value[params[:fields][1]]][params[:fields][2]][value[params[:fields][0]]] = temp
                  # Вставляем в кэш ссылку на элемент
                  cache[value[params[:fields][0]]] = cache[value[params[:fields][1]]][params[:fields][2]][value[params[:fields][0]]]
              # Если элемент кокренвой, вставляем сразу в ret
              else
                temp = {}
                params[:fields].each_with_index do |field, index|
                  case index
                    when 0
                      temp[field] = value[field]
                    when 1
                      temp[field] = value[field]
                    when 2
                      temp[field] = {}
                    else
                      temp[field] = value[field]
                    end
                end
                ret[value[params[:fields][0]]] = temp
                # Вставляем в кэш ссылку на элемент
                cache[value[params[:fields][0]]] = ret[value[params[:fields][0]]]
              end
          end
      end
      ret
    end

    def multidimensional_to_s params
        # return = ''
        parentArray = {}
        if params[:hash].count < 1
            return ''
        end
        level = 1
        parentArray[level] = params[:hash]
        while level >= 1
            # mode = parentArray[level].shift
            mode = parentArray[level].next_element
            puts mode
            puts params[:fields][0]
            exit
            if mode != nil
              print "\t" * (level-1)
              puts mode[params[:fields][0]].to_s
                # return .= str_repeat("\t", $level-1) . $mode[1][$fields[0]] . PHP_EOL;
                if mode[params[:fields][2]].count > 0
                    level+=1
                    parentArray[level] = mode[params[:fields][2]]
                end
            else
                level-=1
            end
        end
    end

    class Hash
      def next_element
        @current_keys ||= self.keys
        self[@current_keys.shift]
      end
    end

end
